class Participant < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  has_many :bookings, :dependent => :destroy, :include => :booker
  accepts_nested_attributes_for :bookings
  has_many :attendants, :dependent => :destroy 
  accepts_nested_attributes_for :attendants
  
  named_scope :search, lambda {|options|
    { :conditions => "name LIKE '%#{options[:name]}%'" }
  }
  
  delegate :payment, :to => :booking
  delegate :session, :status, :status=, :comment, :comment=, :to => :attendant
  
  def booking
    bookings.first
  end
  
  def attendant
    attendants.first
  end
    
  def dropin?
    Session === booking.booker
  end
    
  def self.mailing_list line=false
    members = all(:select => 'DISTINCT email, name', :conditions => 'email REGEXP "@"')
    returning [] do |list|
      members.collect{|member| list << "#{member.name} <#{member.email}>" }
    end.join(line ? '\n' : ', ')
  end
end
