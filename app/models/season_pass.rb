class SeasonPass < Coupon
  after_create :after_coupon_created
  
  def gift_certificate_type= instance
    coupon_type = instance
  end
  
  def gift_certificate_type
    coupon_type
  end
  
  def payment_description
    coupon_type.name
  end
  
  def after_gift_certificate_created
    self.payment.name ||= to_name
    if from_email
      self.payment.save # Make sure the payment is saved
      Notification.deliver_mail("Tack för ditt köp av presentkortet #{ self.coupon_type.name }", from_email, self, '/gift_certificates/create.text.plain.erb')
    end
  end
  
end