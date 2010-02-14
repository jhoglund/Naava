class Attendant < ActiveRecord::Base
  belongs_to :participant
  belongs_to :session
  
  named_scope :attending, :conditions => 'status = 1'
end
