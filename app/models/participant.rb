class Participant < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  has_many :bookings, :dependent => :destroy
  accepts_nested_attributes_for :bookings
  has_many :attendants, :dependent => :destroy 
  accepts_nested_attributes_for :attendants
  
  named_scope :search, lambda {|options|
    { :conditions => "name LIKE '%#{options[:name]}%'" }
  }
    
  def self.mailing_list options={}
    line = options.delete(:line)
    conditions = [options.delete(:conditions) || nil]
    members = all(:select => 'DISTINCT participants.email, participants.name', :conditions => (conditions + ['participants.email REGEXP "@"']).compact.join(' AND '))
    returning [] do |list|
      members.collect{|member| list << "#{member.name} <#{member.email}>" }
    end.join(line ? '\n' : ', ')
  end
end
