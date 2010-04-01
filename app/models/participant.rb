class Participant < ActiveRecord::Base
  has_many :bookings, :dependent => :destroy
  has_many :attendants, :dependent => :destroy 
  
  named_scope :search, lambda {|options|
    { :conditions => "name LIKE '%#{options[:name]}%'" }
  }
end
