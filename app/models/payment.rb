class Payment < ActiveRecord::Base
  include TokenModule
  belongs_to :item, :polymorphic => true, :dependent => :destroy
  belongs_to :reciept, :polymorphic => true
  before_save :add_common_attributes
  #after_create :payment_reciept_after_save
  after_update :payment_reciept_after_save
  
  named_scope :summary, :select => 'sum(value) AS sum'
  
  def paid?
    !reciept.nil?
  end
   
  def pay reciept_instance
    self.reciept = reciept_instance
    save!
  end
   
  def type? type
    reciept.class.name ==  type.to_s.classify
  end
  
  def add_common_attributes
    if item
      write_attribute(:name, item.name) if self.name.blank?
      write_attribute(:email, item.email) if self.email.blank?
    end
  end
  
  def payment_reciept_after_save
    payment_after_disabled
    payment_after_recieved
  end
  
  def self.sum
    self.summary.all.map(&:sum).first.to_i
  end
    
  private
  
  def payment_after_disabled
    if item.class.send :method_defined?, :after_payment_disabled
      if payment_disabled? and email
        item.after_payment_disabled
      end
    end
  end
  
  def payment_after_recieved
    if payment_paid?
      if item.class.send :method_defined?, :after_payment_recieved
        item.after_payment_recieved
      else
        if email
          Notification.deliver_mail("Vi har motagit betalning för din bokning för #{name}", email, self, Notification.get_template(self, 'reciept'))
        end
      end
    end
  end
    
  def payment_paid?
    self.reciept_type_changed? && self.reciept_type_was == nil
    self.reciept_id_changed? && self.reciept_id_was == nil && !reciept.nil?
  end
  
  def payment_disabled?
    item.status_changed? && item.status_was == Status::ACTIVE && item.status == Status::DISABLED
  end
  
end
