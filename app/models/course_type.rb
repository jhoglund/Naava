class CourseType < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 10
  
  has_many :bookings, :as => :booker, :dependent => :nullify
  has_many :users, :through => :bookings
  has_many :sessions, :dependent => :destroy
  belongs_to :instructor
  
  named_scope :active, :conditions => "course_types.status = #{ Status::ACTIVE }"
  named_scope :free, :conditions => "course_types.session_price = 0"
  named_scope :current, lambda{
    { :conditions => { :status => Status::ACTIVE, 
      :id => 
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at <= '#{DateTime.now}'").map(&:id) &
        all(:select => :id, :include => :sessions, :conditions => "sessions.starts_at > '#{DateTime.now}'").map(&:id) 
      } 
    } 
  }
  named_scope :current_or_planned, :include => :sessions, :conditions => "course_types.status = #{ Status::ACTIVE } AND  course_types.id IN (SELECT DISTINCT(sessions.course_type_id)  FROM sessions WHERE sessions.starts_at >= '#{DateTime.now}' ) "
  named_scope :planned, :include => :sessions, :conditions => "course_types.status = #{ Status::ACTIVE } AND  course_types.id NOT IN (SELECT DISTINCT(sessions.course_type_id)  FROM sessions WHERE sessions.starts_at <= '#{DateTime.now}' ) "
  
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
  
  def expired?
    ends_at < Time.now
  end
  
  def course_type_price
    read_attribute(:price)
  end
  
  def course_type_price= price=nil
    write_attribute(:price, price)
  end
  
  def price
    [(remaining_session_count * discounted_price_per_session), original_price].min
  end
  
  def original_price
    course_type_price || original_price_per_session * sessions.active.count
  end
  
  def discounted_price_per_session
    started? ? dropin_price * (0.01 * discount) : original_price_per_session
  end
  
  def price_per_session
    (price.to_f / remaining_session_count).ceil
  end
  
  def original_price_per_session
    session_price || Course.price_per_session
  end
  
  def remaining_session_count
    @remaining_session_count ||= sessions.current.active.count
  end
  
  def fully_booked?
    bookings.count > 22
  end
  
  def free?
    session_price == 0
  end
  
  def self.dropin_price
    AppConfig[:dropin]
  end
  
  def dropin_price
    Course.dropin_price
  end
  
  def discount
    AppConfig[:discount]
  end
  
  def original_discount
    original_price_per_session*100 / AppConfig[:dropin]
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
  
  def description
   Markdown.new(read_attribute(:description)).to_html if read_attribute(:description)
  end
  
  def comment
   Markdown.new(read_attribute(:comment)).to_html if read_attribute(:comment)
  end
  
end