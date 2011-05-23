class CouponType < ActiveRecord::Base
  named_scope :active, :conditions => { :status => Status::ACTIVE }
  def title; name end
end
