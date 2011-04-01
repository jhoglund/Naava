module PaymentModule
  def self.included(base)
    base.send :has_one,  :payment, :as => :item, :dependent => :destroy
    base.send :before_create, :create_payment_before_create
    base.send :accepts_nested_attributes_for, :payment
  end
  
  def paid?
    payment and !payment.reciept.nil?
  end
  
  def create_payment_before_create
    self.payment ||= Payment.new
  end
  
end