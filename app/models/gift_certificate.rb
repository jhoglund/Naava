class GiftCertificate < Coupon
  def gift_certificate_type= instance
    coupon_type = instance
  end
  def gift_certificate_type
    coupon_type
  end
end