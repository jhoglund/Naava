class Session < ActiveRecord::Base
  has_many :bookings, :as => :booker
  has_many :users, :through => :bookings  
  belongs_to :course
  
  named_scope :current, :conditions => "sessions.starts_at > CAST('#{DateTime.now}' AS DATETIME)"
  named_scope :expired, :conditions => "sessions.starts_at < CAST('#{DateTime.now}' AS DATETIME)"
  named_scope :by_date, lambda{|asc|
    { :order => "sessions.starts_at #{asc === false ? "DESC" : "ASC"}" }
  }
  named_scope :week, lambda{|date|
    date ||= Date.today
    start = date - (date.wday - 1)
    stop = start + 7
    { :conditions => "sessions.starts_at BETWEEN date('#{start}') AND date('#{stop}') OR sessions.starts_at BETWEEN date('#{start}') AND date('#{stop}')"}
  }
    
  delegate :name, :to => :course
  
  attr_writer :duration_hours, :duration_minutes
  
  before_save :save_duration
    
  def price
    AppConfig[:dropin]
  end
  
  def expired?
    starts_at < Time.now
  end
  
  def starts_at
    time = read_attribute(:starts_at)
    return time unless time.nil? 
    time = Time.now
    return time - (time.min*60) - time.sec
  end
  alias :start :starts_at
  
  def ends_at
    time = read_attribute(:ends_at)
    return time unless time.nil? 
    time = Time.now
    return starts_at + 5400
  end
  alias :stop :ends_at
  
  
  def duration
    Time.at(-3600 + (duration_as_int * 3600)) 
  end
  
  def duration_hours
    duration_as_int.floor
  end
  
  def duration_minutes
    ((duration_as_int % 1) * 60).to_i
  end
  
  def save_duration
    write_attribute(:ends_at, starts_at + ((@duration_hours.to_i * 3600) + (@duration_minutes.to_i * 60)))
  end
  
  private
  
  def duration_as_int
    (ends_at - starts_at).round.to_f / 3600
  end
  
end
