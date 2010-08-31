class Booking < ActiveRecord::Base
  include PaymentModule
  include TokenModule
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :participant, :dependent => :destroy
  belongs_to :booker, :polymorphic => true
  accepts_nested_attributes_for :participant, :allow_destroy => true
  delegate :name, :email, :phone, :name=, :email=, :phone=, :to => :participant
  after_create :reset_attributes, :after_booking_created
  after_update :after_booking_disabled
  
  named_scope :sessions, :conditions => { :booker_type => 'Session'}
  named_scope :courses, :conditions => { :booker_type => 'Course'}
  named_scope :active, :conditions => "bookings.status = #{Status::ACTIVE}"
  named_scope :disabled, :conditions => "bookings.status = #{Status::DISABLED}"
  named_scope :by_id, lambda{|order|
    order ||= :asc
    { :order => "id #{order.to_s.upcase}" }
  }
  named_scope :by_booker, lambda{|options|
    if !options[:session].nil?
      course_id = Session.find(options[:session]).course_id
      conditions = ["(bookings.booker_type = 'Session' AND bookings.booker_id = :session) OR (bookings.booker_type = 'Course' AND bookings.booker_id = :course)", {:session => options[:session], :course => course_id}] 
    elsif !options[:course].nil?
      conditions = ["(bookings.booker_type = 'Course' AND bookings.booker_id = :course)", {:course => options[:course]}] 
    end
    { 
      :conditions => conditions || [],
      :order => 'bookings.created_at DESC'
    }
  }
  
  
  validates_presence_of :name, :on => :create
  validate :phone_or_email
  
  EMAIL_PATTERN = /\A[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum)\z/i
  
  attr_writer :notify_by_mail
  
  attr_accessor :free
  
  def free?
    if payment
      payment.free?
    elsif booker and defined?(booker.free?)
      booker.free?
    end
  end
  
  def notify?
    @notify_by_mail != false
  end
  
  def drop_in?
    booker.is_a? Session
  end
  
  def valid_mail
    email =~ EMAIL_PATTERN
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
    # We need to save the association "payment" so we can get the id in the mail
    if email and notify? and self.payment.save
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
