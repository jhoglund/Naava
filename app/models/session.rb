class Session < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
  has_many :bookings, :as => :booker
  has_many :attendants  
  belongs_to :course, :foreign_key => 'course_type_id'
  belongs_to :course_type, :foreign_key => 'course_type_id'
  belongs_to :workshop, :foreign_key => 'course_type_id'
  
  named_scope :current, :conditions => "sessions.starts_at > CAST('#{DateTime.now}' AS DATETIME)"
  named_scope :expired, :conditions => "sessions.starts_at < CAST('#{DateTime.now}' AS DATETIME)"
  named_scope :active, lambda{|active_course|
    { 
      :conditions => "sessions.status = 1#{(active_course ? '  AND course_types.status = 1' : '')}", 
      :include => 'course'
    }
  }
  named_scope :asc, :order => "sessions.starts_at ASC"
  named_scope :desc, :order => "sessions.starts_at DESC"
  named_scope :week, lambda{|date|
    date ||= Date.today
    start = date - (date.wday - 1)
    stop = start + 7
    { :conditions => "sessions.starts_at BETWEEN date('#{start}') AND date('#{stop}') OR sessions.starts_at BETWEEN date('#{start}') AND date('#{stop}')"}
  }
    
  delegate :name, :to => :course_type
  
  attr_writer :duration_hours, :duration_minutes
  
  before_save :save_duration
  
  accepts_nested_attributes_for :attendants
  accepts_nested_attributes_for :bookings
  
  def attending? participant
    @attending_participant ||= attendants.attending.map(&:participant_id)
    @attending_participant.include?(participant.id)
  end
  
  def participants
    Booking.all(:conditions => ['(booker_id = :course_type_id AND booker_type = "CourseType") OR (booker_id = :session_id AND booker_type = "Session")', { :course_type_id => self.course_type_id, :session_id => self.id}]).map(&:participant)
  end
  
  def self.price
    AppConfig[:dropin]
  end
  
  def price
    Session.price
  end
  
  def free?
    course ? course.free? : false
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
  
  def date
    starts_at.to_date
  end
  
  def duration
    Time.utc(1970,"jan",1,0,0,0) + (duration_as_int * (60*60))
  end
  
  def duration_hours
    duration_as_int.floor
  end
  
  def duration_minutes
    ((duration_as_int % 1) * 60).to_i
  end
  
  def save_duration
    write_attribute(:ends_at, starts_at + ((@duration_hours.to_i*(60*60)) + (@duration_minutes.to_i * 60)))
  end
  
  def duration_as_int
    (ends_at - starts_at).round.to_f / (60*60)
  end
  
  def canceled?
    status == 0
  end
    
  def next by_course=true
    conditions = "timestamp(starts_at) > timestamp('#{starts_at.to_s(:db)}') AND status = 1"
    conditions << " AND course_type_id = #{course_type_id}" if by_course
    Session.find(:first, :conditions => conditions, :order => 'starts_at')
  end
  
  def previous by_course=true
    conditions = "timestamp(starts_at) < timestamp('#{starts_at.to_s(:db)}') AND status = 1"
    conditions << " AND course_type_id = #{course_type_id}" if by_course
    Session.find(:last, :conditions => conditions, :order => 'starts_at')
  end
  
  def to_fullcalendar
    timepattern = '%Y-%m-%d %H:%M:%S'
    { 
      :title => (course_type.nil? ? 'Untitled' : "#{starts_at.strftime('%H:%M')}\n #{course_type.name}"), 
      :start => starts_at.strftime(timepattern), 
      :end => ends_at.strftime(timepattern), 
      :url => status==1 ? "klasser/#{id}/boka" : false,
      :className => canceled? ? 'calendar-session-disabled' : "calendar-session-#{course.nil? ? 'default' : course.level.gsub(/([åäö])/i,'').downcase}",
      :tooltip => canceled? ? comment : 'Klicka för att boka plats'
    }
  end
  
  protected
  
  def after_booking_created
    self.payment.name ||= self.participant.name
    super
  end
  
end
