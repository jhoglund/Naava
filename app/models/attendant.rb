class Attendant < ActiveRecord::Base
  belongs_to :participant
  accepts_nested_attributes_for :participant
  belongs_to :session
  
  named_scope :attending, :conditions => 'attendants.status = 1'
  
  named_scope :search, lambda {|options|
    { 
      :include => :participant,
      :conditions => "participants.name LIKE '%#{options[:name]}%'" 
    }
  }
  
  default_scope :order => 'sessions.starts_at', :include => :session
  
  def attending?
    status == 1
  end
end
