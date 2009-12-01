class Session < ActiveRecord::Base
  has_many :bookings, :as => :booker
  has_many :users, :through => :bookings  
  belongs_to :course
    
  delegate :name, :to => :course
end
