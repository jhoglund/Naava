class Coupon < ActiveRecord::Base
  include PaymentModule
  include TokenModule
  token_type :string
  cattr_reader :per_page
  @@per_page = 10
  
  belongs_to :coupon_type
  has_many :payment_reciepts, :class_name => "Payment", :as => :reciept
  
  validates_presence_of :to_name, :from_name, :on => :create
  validate :phone_or_email
  
  delegate :value, :valid_for?, :to => :coupon_type
  
  EMAIL_EXP = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i
  PHONE_EXP = /\d+|\+/
  
  def email; from_email end
  def name; from_name end
  def title; coupon_type.title end
  def phone; from_phone end
  
  def payment_description
    "#{coupon_type.class.human_name}: #{coupon_type.name}"
  end
  
  def to_s
    "#{to_name}, #{coupon_type.name} (#{available_funds})"
  end
  
  def use! payment, value=nil
    use(payment, value)
    save
  end
  
  def to_param
    token
  end
  
  def use payment, value=nil
    # Vänta med detta. Det funkar inte så bra i och med att man kan betala via bankgiro, som har några dagars fördröjning
    # if !payment.paid?
    #   raise Payment::UnsufficentFunds
    # else
      payment.value = value if value
      self.payment_reciepts << payment
    # end
  end
  
  def valid_dates
    now = Time.now
    (self.valid_from.nil? or now >= self.valid_from) and (self.valid_to.nil? or self.valid_to >= now)
  end
  
  def is_valid? value=nil
    if self.new_record?
      true
    elsif self.valid_dates
      if coupon_type.value.nil?
        true
      elsif coupon_type.times
        payment_reciepts.count < coupon_type.times
      else
        available_funds >= value
      end
    end
  end
  
  def self.active
    Coupon.all.select{|coupon| coupon.is_valid? }
  end
    
  def original_funds
    if coupon_type.times
      coupon_type.times
    else
      coupon_type.value
    end
  end
  
  def available_times
    if coupon_type.times
      original_funds - payment_reciepts.count
    else
      nil
    end
  end
  
  def available_funds
    if coupon_type.value.nil?
      0
    elsif coupon_type.times
      original_funds - payment_reciepts.count
    else
      self.original_funds - payment_reciepts.sum(:value)
    end
  end
  
  def no_funds?
    self.available_funds <= 0
  end
  
  def full_funds?
    self.available_funds == coupon_type.value
  end
    
  def valid_mail attribute
    attribute =~ EMAIL_EXP
  end
  
  def valid_phone attribute
    return false unless attribute.is_a?(String)
    attribute.scan(PHONE_EXP).join.size > 4
  end
  
  def valid_mail attribute
    attribute =~ EMAIL_EXP
  end    
  
  def valid_phone_or_email(email_attribute=nil, phone_attribute=nil)
    valid_mail(email_attribute) or valid_phone(phone_attribute)
  end
  
  def phone_or_email
    return true if valid_phone_or_email(self.from_email, self.from_phone)
    #self.errors.add(:to_email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail(self.to_email) or valid_phone(self.to_phone)
    #self.errors.add(:to_phone, I18n.t('activerecord.errors.messages.invalid')) unless valid_phone(self.to_phone) or valid_mail(self.to_email)
    self.errors.add(:from_email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail(self.from_email) or valid_phone(self.from_phone)
    self.errors.add(:from_phone, I18n.t('activerecord.errors.messages.invalid')) unless valid_phone(self.from_phone) or valid_mail(self.from_email)
    self.errors.add_to_base(I18n.t('activerecord.errors.messages.coupon_type_phone_or_email')) unless valid_phone_or_email(self.to_email, self.to_phone) and valid_phone_or_email(self.from_email, self.from_phone)
    return false
  end
  
  def after_payment_recieved
    if email
      Notification.deliver_mail("Vi har motagit betalning för ditt presentkort till #{to_name}", email, self, Notification.get_template(self, 'reciept'))
    end
  end
    
end
