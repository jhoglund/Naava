class GiftCertificate < Coupon
  after_create :after_gift_certificate_created
  
  def gift_certificate_type= instance
    coupon_type = instance
  end
  
  def gift_certificate_type
    coupon_type
  end  
  
  def after_gift_certificate_created
    self.payment.name ||= to_name
    if from_email
      self.payment.save # Make sure the payment is saved
      Notification.deliver_mail("Tack för ditt köp av presentkortet #{ self.coupon_type.name }", from_email, self, '/gift_certificates/create.text.plain.haml')
    end
  end
  
end