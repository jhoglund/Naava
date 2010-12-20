class Course < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
  has_many :bookings, :as => :booker, :dependent => :nullify
  has_many :users, :through => :bookings
  has_many :sessions, :dependent => :destroy
  belongs_to :instructor
  
  named_scope :active, :conditions => "courses.status = #{ Status::ACTIVE }"
  named_scope :free, :conditions => "courses.session_price = 0"
  named_scope :current, lambda{
    { :conditions => { :status => Status::ACTIVE, 
      :id => 
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at <= '#{DateTime.now}'").map(&:id) &
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at > '#{DateTime.now}'").map(&:id) 
      } 
    } 
  }
  named_scope :current_or_planned, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND  courses.id IN (SELECT DISTINCT(sessions.course_id)  FROM sessions WHERE sessions.starts_at >= '#{DateTime.now}' ) "
  named_scope :planned, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND  courses.id NOT IN (SELECT DISTINCT(sessions.course_id)  FROM sessions WHERE sessions.starts_at <= '#{DateTime.now}' ) "
  
  #after_update :save_sessions
  
  accepts_nested_attributes_for :sessions, :allow_destroy => true
  accepts_nested_attributes_for :instructor, :allow_destroy => true
    
  def self.price_per_session
    AppConfig[:course_per_class]
  end
  
  def self.price times=1
    Course.price_per_session * times
  end
    
  def next_session
    sessions.active.current.asc.first
  end
  
  def default_session
    sessions.asc.first
  end
  
  def starts_at
    sessions.active.asc.first.starts_at if sessions.active.first
  end
  
  def ends_at
    sessions.active.asc.last.starts_at if sessions.active.last
  end
  
  def price
    sessions.active.current.count * price_per_session
  end
  
  def original_price
    Course.price(sessions.active.count)
  end
  
  def price_per_session
    (started? ? session_price : original_price_per_session) * (0.01 * discount)
  end
  
  def original_price_per_session
    session_price || Course.price_per_session
  end
  
  def free?
    session_price == 0
  end
  
  def discount
    85
  end
  
  def dropin_price
    session_price || AppConfig[:dropin]
  end
  
  def original_discount
    Course.price_per_session*100 / dropin_price
  end
  
  def discounted?
    
  end
  
  def started?
    sessions.active.expired.count > 0
  end
  
  def ended?
    sessions.active.current.count == 0
  end
  
  def remaining_sessions? count=1
    sessions.active.current.count > count
  end
  
end
