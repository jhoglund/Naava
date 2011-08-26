class CouponType < ActiveRecord::Base
  serialize :valid_for
  named_scope :active, :conditions => { :status => Status::ACTIVE }
  def title; name end
  
  def valid_for? obj
    name = case obj.class.name
      when 'String' then obj
      when 'Symbol' then obj.to_s
      when 'Class' then obj.name
      else obj.class.name
    end
    self.valid_for.map(&:downcase).include? name.downcase if self.valid_for
  end
  
end
