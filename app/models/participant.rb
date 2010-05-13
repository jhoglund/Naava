class Participant < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  has_many :bookings, :dependent => :destroy
  has_many :attendants, :dependent => :destroy 
  
  named_scope :search, lambda {|options|
    { :conditions => "name LIKE '%#{options[:name]}%'" }
  }
end
