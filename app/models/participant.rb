class Participant < ActiveRecord::Base
  has_many :bookings, :dependent => :destroy
  has_many :attendants, :dependent => :destroy 
end
