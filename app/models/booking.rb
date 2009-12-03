class Booking < ActiveRecord::Base
  belongs_to :participant
  belongs_to :booker, :polymorphic => true
  has_one :payment, :class_name => 'PaypalReciept', :as => :item
  accepts_nested_attributes_for :participant, :allow_destroy => true
  delegate :name, :email, :phone, :name=, :email=, :phone=, :to => :participant
  before_create :make_token
  after_create :reset_attributes
  
  before_update :disabling?
    
  named_scope :active, :conditions => "bookings.status = #{Status::ACTIVE}"
  named_scope :disabled, :conditions => "bookings.status = #{Status::DISABLED}"
  
  validates_presence_of :name, :on => :create
  validate :phone_or_email
  
  def drop_in?
    booker.is_a? Session
  end
  
  def to_param
    token
  end
  
  def valid_mail
    email =~ /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i
  end
  
  def valid_phone
    phone.scan(/\d+|\+/).join.size > 4
  end
  
  def phone_or_email
    return true if valid_mail or valid_phone
    self.errors.add_to_base(I18n.t('activerecord.errors.messages.phone_or_email'))
    self.errors.add(:email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail
    self.errors.add(:phone, I18n.t('activerecord.errors.messages.invalid')) unless valid_phone
    return false
  end
  
  def disabling?
    self.status_changed? && self.status_was == Status::ACTIVE && self.status == Status::DISABLED
  end
    
  private  
  
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def make_token
    self.token = secure_digest(Time.now, (1..10).map{ rand.to_s })
  end
  
  def reset_attributes
    self.update_attribute :email, nil unless valid_mail
    self.update_attribute :phone, nil unless valid_phone
  end
  
end
