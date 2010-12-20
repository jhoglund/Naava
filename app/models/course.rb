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
    
  class << self
    
    def price_per_session type=:dropin
      case type.to_sym
      when :discounted
        discount * dropin_price_per_session
      when :full_discounted
        full_discount * dropin_price_per_session
      else
        dropin_price_per_session
      end
    end
    
    def price times=1, type=:dropin
      price_per_session(type) * times
    end
  
    def discount
      0.01 * AppConfig[:discount][:started]
    end

    def full_discount
      0.01 * AppConfig[:discount][:full]
    end
    
    def dropin_price_per_session
      Session.price
    end
  
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
  
  def price_per_session type=:dropin
    case type.to_sym
    when :discounted
      dicounted_price_per_session
    when :full_discounted
      full_dicounted_price_per_session
    else
      dropin_price_per_session
    end
  end
  
  def dicounted_price_per_session
    discount * session_price
  end
  
  def full_dicounted_price_per_session
    full_discount * session_price
  end
  
  def original_price
    session_count * full_dicounted_price_per_session
  end

  def price
    session_count(:remaining) * dicounted_price_per_session
  end
  
  def dropin_price_per_session
    session_price || Course.dropin_price_per_session
  end
  
  def session_count count=:all
    case count.to_sym
    when :remaining
      sessions.active.current.count
    when :expired
      sessions.active.expired.count
    else
      sessions.active.count
    end
  end
  
  def free?
    session_price === 0
  end
  
  def discount
    Course.discount
  end
  
  def full_discount
    Course.full_discount
  end
  
  def discounted?
    
  end
  
  def started?
    session_count(:expired) > 0
  end
  
  def ended?
    session_count(:remaining) == 0
  end
  
  def remaining_sessions? count=1
    session_count(:remaining) > count
  end
  
end
