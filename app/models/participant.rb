class Participant < ActiveRecord::Base
  has_many :bookings
  has_many :attendants  
end
