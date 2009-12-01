class Participant < ActiveRecord::Base
  has_many :bookings
end
