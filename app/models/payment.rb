class Payment < ActiveRecord::Base
  class UnsufficentFunds < StandardError
  end
  cattr_reader :per_page
  @@per_page = 10
  
  include TokenModule
  belongs_to :item, :polymorphic => true, :dependent => :destroy
  belongs_to :reciept, :polymorphic => true
  before_save :add_common_attributes
  #after_create :payment_reciept_after_save
  after_update :payment_reciept_after_save
  
  named_scope :summary, :select => 'sum(value) AS sum'
  
  named_scope :by_id, lambda{|order|
    order ||= :asc
    { :order => "id #{order.to_s.upcase}" }
  }
  
  named_scope :by_paid, :order => 'reciept_type NOT NULL'
  
  named_scope :paid, :conditions => 'reciept_type IS NOT NULL'
  named_scope :not_paid, :conditions => 'reciept_type IS NULL'
  named_scope :paid_or_not, :conditions => ''
  
  named_scope :search, lambda {|query|
    { 
      :conditions => "(payments.id LIKE '%#{query||'*'}%' OR payments.name LIKE '%#{query}%')" 
    }
  }
  
  attr_writer :notify_by_mail, :free
  
  def description
    item.respond_to?(:payment_description) ? item.payment_description : ''
  end
  
  def free
    free?
  end
  
  def free?
    type? :free
  end
  
  def paid?
    !reciept.nil?
  end
   
  def pay reciept_instance
    self.reciept = reciept_instance
    save!
  end
   
  def type? type
    reciept ===  type.to_s.classify.constantize
  end
  
  def notify?
    @notify_by_mail != false
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
  
  def reciept_attributes= attributes
    case attributes.delete(:type)
      when 'bg'
        self.reciept = Bankgiro.new(attributes[:bg]) 
        self.value = self.reciept.gross
      when 'cash'
        self.reciept = Cash.new(attributes[:cash]) 
        self.value = self.reciept.gross
      when 'free'
        self.reciept = Free.new(attributes[:free])
        self.value = 0
      when 'coupon'
        coupon = Coupon.find(attributes[:coupon][:id])
        self.reciept = coupon
        self.value = attributes[:coupon][:value] || (item.price unless item.nil?)
      else
        self.reciept.destroy unless self.reciept.nil?
    end
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
        if email and notify?
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
