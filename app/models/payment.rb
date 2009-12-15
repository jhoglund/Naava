class Payment < ActiveRecord::Base
  include TokenModule
  belongs_to :item, :polymorphic => true
  belongs_to :reciept, :polymorphic => true
  before_save :add_common_attributes
  after_create :payment_reciept_after_create
  after_update :payment_reciept_after_update
  
  def paid?
    !reciept.nil?
  end
   
  def pay reciept_instance
    self.reciept = reciept_instance
    save!
  end
   
  def type? type
    case 
    when :paypal
      reciept.is_a? PaypalReciept
    end
  end
  
  def add_common_attributes
    write_attribute(:name, item.name) if self.name.blank?
    write_attribute(:email, item.email) if self.email.blank?
  end
  
  def payment_reciept_after_create
    if item.class.send :method_defined?, :after_payment_created
      item.after_payment_created
    else
      if email
        Notification.deliver_mail("Vi har motagit betalning för din bokning för #{name}", email, self, Notification.get_template(self, 'reciept'))
      end
    end
  end
  
  def payment_reciept_after_update
    if item.class.send :method_defined?, :after_payment_disabled
      if payment_disabled? and email
        item.after_payment_disabled
      end
    end
  end
  
  private
    
  def payment_disabled?
    item.status_changed? && item.status_was == Status::ACTIVE && item.status == Status::DISABLED
  end
  
end
