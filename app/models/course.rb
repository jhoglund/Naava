class Course < ActiveRecord::Base
  has_many :bookings, :as => :booker
  has_many :users, :through => :bookings
  has_many :sessions
  
  named_scope :active, :conditions => "courses.status = #{ Status::ACTIVE }"
  named_scope :current, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND sessions.starts_at <= date('#{Date.today}') "
  named_scope :planned, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND sessions.starts_at > date('#{Date.today}') "
  
  
  def starts_at
    sessions.first.starts_at if sessions.first
  end
  
  def ends_at
    sessions.last.starts_at if sessions.last
  end
  
end
