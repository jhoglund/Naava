class Course < ActiveRecord::Base
  has_many :bookings, :as => :booker, :dependent => :nullify
  has_many :users, :through => :bookings
  has_many :sessions, :dependent => :destroy
  belongs_to :instructor
  
  named_scope :active, :conditions => "courses.status = #{ Status::ACTIVE }"
  named_scope :current, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND sessions.starts_at <= date('#{Date.today}') "
  named_scope :planned, :include => :sessions, :conditions => "courses.status = #{ Status::ACTIVE } AND sessions.starts_at > date('#{Date.today}') "
  
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
    sessions.current.asc.first
  end
  
  def starts_at
    sessions.current.asc.first.starts_at if sessions.first
  end
  
  def ends_at
    sessions.current.asc.last.starts_at if sessions.last
  end
  
  def price
    sessions.current.count * price_per_session
  end
  
  def original_price
    Course.price(sessions.count)
  end
  
  def price_per_session
    AppConfig[:dropin] * (0.01 * discount)
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
    sessions.expired.count > 0
  end
  
  def ended?
    sessions.current.count == 0
  end
  
end
