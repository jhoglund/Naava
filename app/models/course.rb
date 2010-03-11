class Course < ActiveRecord::Base
  has_many :bookings, :as => :booker, :dependent => :nullify
  has_many :users, :through => :bookings
  has_many :sessions, :dependent => :destroy
  belongs_to :instructor
  
  named_scope :active, :conditions => "courses.status = #{ Status::ACTIVE }"
  named_scope :current, lambda{
    { :conditions => { :status => Status::ACTIVE, 
      :id => 
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at <= date('#{Date.today}')").map(&:id) &
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at > date('#{Date.today}')").map(&:id) 
      } 
    } 
  }
  named_scope :planned, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND  courses.id NOT IN (SELECT DISTINCT(sessions.course_id)  FROM sessions WHERE sessions.starts_at <= date('#{Date.today}') ) "
  
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
  
  def starts_at
    sessions.active.asc.first.starts_at if sessions.first
  end
  
  def ends_at
    sessions.active.asc.last.starts_at if sessions.last
  end
  
  def price
    sessions.active.current.count * price_per_session
  end
  
  def original_price
    Course.price(sessions.active.count)
  end
  
  def price_per_session
    started? ? AppConfig[:dropin] * (0.01 * discount) : original_price_per_session
  end
  
  def original_price_per_session
    Course.price_per_session
  end
  
  def discount
    85
  end
  
  def original_discount
    Course.price_per_session*100 / AppConfig[:dropin]
  end
  
  def started?
    sessions.active.expired.count > 0
  end
  
  def ended?
    sessions.active.current.count == 0
  end
  
end
