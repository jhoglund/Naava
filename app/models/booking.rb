class Booking < ActiveRecord::Base
  include PaymentModule
  include TokenModule

  belongs_to :participant, :dependent => :destroy
  belongs_to :booker, :polymorphic => true
  accepts_nested_attributes_for :participant, :allow_destroy => true
  delegate :name, :email, :phone, :name=, :email=, :phone=, :to => :participant
  after_create :reset_attributes, :after_booking_created
  after_update :after_booking_disabled
  
  #before_update :disabling?
    
  named_scope :active, :conditions => "bookings.status = #{Status::ACTIVE}"
  named_scope :disabled, :conditions => "bookings.status = #{Status::DISABLED}"
    
  
  validates_presence_of :name, :on => :create
  validate :phone_or_email
  
  attr_writer :notify_by_mail
  
  def notify?
    @notify_by_mail != false
  end
  
  def drop_in?
    booker.is_a? Session
  end
  
  def valid_mail
    email =~ /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i
  end
  
  def valid_phone
    phone.scan(/\d+|\+/).join.size > 4
  end
  
  def phone_or_email
    return true if valid_mail or valid_phone
    self.errors.add(:email, I18n.t('activerecord.errors.messages.invalid')) unless valid_mail
    self.errors.add(:phone, I18n.t('activerecord.errors.messages.invalid')) unless valid_phone
    self.errors.add_to_base(I18n.t('activerecord.errors.messages.phone_or_email'))
    return false
  end
    
  def after_payment_disabled
    #Notification.deliver_mail("Refund needed for #{reciept.transaction_id}", AppConfig[:support_mail], reciept, 'refund')
  end
  
  def after_booking_created
    if email and notify?
      Notification.deliver_mail("Vi har motagning din bokning för #{name}", email, self, Notification.get_template(self.booker, 'create'))
    end
  end
  
  
  def after_booking_disabled
    if disabling? and email and notify?
      Notification.deliver_mail("Din bokning har blivit borttagen för #{name}", email, self, Notification.get_template(self.booker, 'destroy'))
    end
  end
      
  private  
  
  def disabling?
    self.status_changed? && self.status_was == Status::ACTIVE && self.status == Status::DISABLED
  end
  
  def reset_attributes
    self.update_attribute :email, nil unless valid_mail
    self.update_attribute :phone, nil unless valid_phone
  end
  
end
