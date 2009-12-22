class Coupon < ActiveRecord::Base
  include PaymentModule
  include TokenModule
  token_type :string
  
  belongs_to :coupon_type
  has_many :payment_reciepts, :class_name => "Payment", :as => :reciept
  
  validates_presence_of :to_name, :from_name, :on => :create
  validate :phone_or_email
  EMAIL_EXP = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i
  PHONE_EXP = /\d+|\+/
  
  def email; from_email end
  def name; from_name end
  def title; coupon_type.title end
  def phone; from_phone end
    
  def original_funds
    coupon_type.value
  end
  
  def available_funds
    self.original_funds - payment_reciepts.sum(:value)
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
    return true if valid_phone_or_email(self.to_email, self.to_phone) and valid_phone_or_email(self.from_email, self.from_phone)
    self.errors.add(:to_email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail(self.to_email) or valid_phone(self.to_phone)
    self.errors.add(:from_email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail(self.from_email) or valid_phone(self.from_phone)
    self.errors.add(:to_phone, I18n.t('activerecord.errors.messages.invalid')) unless valid_phone(self.to_phone) or valid_mail(self.to_email)
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