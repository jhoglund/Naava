module CalendarHelper
  
  def calendar_date name = :calendar, time=nil
    return Date.parse(Time.now.to_s)
    session[:calendars] ||= {}
	  session[:calendars][name] ||= {}
    session[:calendars][name] = if session[:calendars][name].empty? and !time then Time.now.to_s
                                elsif !time then session[:calendars][name]
                                else time.to_s end
	  Date.parse(session[:calendars][name])
  end
  
  def calendar date=nil, view = :month
    return @calendar if @calendar
    date = date ? to_date(date) : calendar_date(:calendar, params[:calendar_date])
    @calendar = Stixy::Calendar.new(date, view, 0) 
  end
  
  def activities start=nil, stop=nil, options = { :reload => false, :cache => true }
    return @arranged_activities if @arranged_activities and options[:reload] == false
    unless start
      start = calendar().start
      stop = calendar().stop
    else
      stop ||= start
    end
    # Create a array of all activities to be included in the calendar
	  activities = options[:activities]
    @activities = activities.flatten.sort_by{ |a| a.start }
    arranged_activities = {}
    @activities.each do |a|
      activity = Stixy::Calendar::Event.new(a.start, a.stop, a) 
      index = nil
      activity.start = activity.start
      activity.stop = activity.stop
	    to_date(activity.start).upto(to_date(activity.stop)) do |date|
	      date_name = date.to_s
	      arranged_activities[date_name] ||= []
	      index = nil if date.wday == 0
  	    if index.nil?
          arranged_activities[date_name] << activity
	        index = arranged_activities[date_name].index(activity)
        else
          arranged_activities[date_name][index] = activity
        end
	    end
    end
    @arranged_activities = arranged_activities if options[:cache] == true
    return arranged_activities
  end
  
  def generate_calendar date = nil, calendar_activities = nil
    generate_week_calendar(date)
  end
  
  def generate_week_calendar date = Date.new
    # Generate a list of all activities as a multi dimenssional array. 
    # One entry per day, including a array with the events for the specific day
  	@calendar_table = calendar(to_date(date), :week).to_html_table do |calendar_day, date, time, cell|
  		@date, @calendar_day = date, calendar_day
  		day_num = Stixy::Html::Element.new("div")
  		#day_num.setAttribute(:class, "calendar-day-number")
  		day_num.content = date.day
  		#day_num.content = "Today " + date.day.to_s if compare_dates(Time.now, date)
  		cell.addChildNode(day_num)
  		if calendar_day.first_weekday? and (time.min==0)
  		  timeElement = Stixy::Html::Element.new("div")
  		  timeElement.content = l(time, :format => :time)
    		timeElement.setAttribute(:class, 'time')
    		cell.addChildNode(timeElement)
		  end
      #cell.setAttribute(:title, date.to_s)
      #cell.setAttribute("sx:date", date.to_s)
      #if @selected_day and compare_dates(@selected_day, date)
      #  cell.addAttribute(:class, "calendar-selected-day")
      #  cell.setAttribute("sx:id", "selected-day")
      #end
      if current_day = activities(nil, nil, :activities => Session.all)[date.to_s]
  		  current_day.each_with_index do |event, index|
          @event, @index = event, index
          unless  @event.nil?
            entryTag = Stixy::Html::Element.new("sx:entry")
      		  entryTag.setAttribute("sx:entry-id", (event.nil? ? 0 : event.id))
      		  entryTag.setAttribute("sx:entry-type", event.class.to_s.underscore)
      		  if do_not_print_event?
    		    	entryTag.content = "&nbsp;"
        	  else
        	    entryTag.addAttribute(:class, class_names)
              entryTag.setAttribute(:title, event.object.course.description)
              labelTag = Stixy::Html::Element.new("sx:label")
        		  labelTag.content = "jonas"#render(:partial => get_partial(@event,:calendar), :object => @event)
    		    	entryTag.addChildNode(labelTag)
        		end
            cell.addChildNode(entryTag)
          end
    		end
  		end
  	end
    @calendar_table.setHeaders(*@calendar.offsetDays(Date::DAYNAMES.dup))
    @calendar_table.addAttribute(:class, "stixy-calendar")
    return  @calendar_table.to_s
  end
  
  def class_names
    className = []
    className << "start"   if event_first_week?
    className << "stop"    if event_last_week?
    className << "middle"  if !event_first_week? and !event_last_week?
    className = [className.join("-")]
    #className << "calendar-entry-selected" if calendar_entry_selected?
    className << "multiple" if multi_day_event?
    stretch_names = %w{ one two three four five six seven }
    className << stretch_names[stretch_days_position]
    return className.join(" ")
  end
  
  def calendar_entry_selected?
    @event.id == @entry.id rescue nil
  end
  
  def do_not_print_event?
    !compare_dates(event_start_of_week, @date)
  end
  
  def multi_day_event? ev=@event
    !compare_dates(ev.start, ev.stop)
  end
  
  def event_first_week?
    compare_dates(@event.start, @date) || compare_dates(@event.start, @calendar_day.start_of_week){|left, right| left  >= right }
  end
  
  def event_last_week?
    compare_dates(@event.stop, @date) || compare_dates(@event.stop, @calendar_day.end_of_week){|left, right| left <= right }
  end
  
  def event_middle_week?
    !compare_dates(@event.start, @date) and !compare_dates(@event.stop, @date)
  end
  
  def event_last_day?
    compare_dates(@event.stop, @date) || compare_dates(@event.stop, event_end_of_week){|left, right| left <= right }
  end
  
  def event_start_of_week
    if compare_dates(@event.start,  @calendar_day.start_of_week){|left, right| left >= right }
      return @event.start
    else
      return  @calendar_day.start_of_week
    end
  end
  
  def event_end_of_week
    if compare_dates(@event.stop, @calendar_day.end_of_week){|left, right| left <= right }
      return @event.stop
    else
      return @calendar_day.end_of_week
    end
  end

  def stretch_days
    stretch_days_position + 1
  end

  def stretch_days_position
    (to_date(event_end_of_week) - to_date(event_start_of_week)).to_i
  end  
  
  def to_date klass
    return klass.class==Date ? klass : Date.parse(klass.to_s)
  end
  
  def compare_dates left=Time.now, right=Time.now
    left = left.class == Date ? left : Date.parse(left.to_s)
    right = right.class == Date ? right : Date.parse(right.to_s)
    return yield(left, right) if block_given?
    return left == right
  end
  
  
end

