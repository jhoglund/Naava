class Participant < ActiveRecord::Base
  has_many :bookings, :dependent => :destroy
  has_many :attendants, :dependent => :destroy 
  
  def attending?
    !attendants.attending.blank?
  end
end
