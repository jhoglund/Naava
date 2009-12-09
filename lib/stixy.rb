module Stixy
  
  module Html
  
    class Element
      attr_accessor :content      
    
      def initialize name, content=""
        @attributes = Attributes.new
        @children = Children.new
        @name = name.to_s.downcase
        @content = content
      end
    
      def addChildNode child
        @children << child
        return child
      end
    
      def addChild name="div", value=""
        addChildNode(Element.new(name.to_s, value))
      end
    
      def setAttribute name, values
        @attributes[name.to_s] ||= Attribute.new(name, values)
      end
    
      def addAttribute name, values
        if attribute = @attributes[name.to_s]
          attribute.values = values.to_s
        else
          @attributes[name.to_s] ||= Attribute.new(name, values)
        end
      end
      
      def attributes= options={}
        options.each do |key,value|
          setAttribute(key,value)
        end
        @attributes
      end
      
      def attributes
        @attributes
      end
    
      def getAttribute name
        @attributes[name.to_s]
      end
    
      def removeAttribute name
        @attributes.delete(name.to_s)
      end
    
      def to_s
        tagify
      end
      
      protected
      
      def tagify
        "<#{@name.downcase}#{attributes.to_s}>#{@children.to_s}#{@content}</#{@name.downcase}>"
      end
      
      def tabs size=0
        str = ""
        (0...size).each do 
          str += "\t"
        end
        return str
      end
    
    end
    
    class Children < Array
      def to_s 
        str = ""
        self.each do |child|
          str += child.to_s
        end
        return str
      end
    end
    
    class Attributes < Hash
      def to_s
        str = ""
        self.each do |name, attribute|
          str << " #{attribute.to_s}"
        end
        return str
      end
      def to_h
        h = {}
        self.each do |name, attribute|
          h.merge!(name.to_sym => attribute.values)
        end
        return h
      end
    end
  
    class Attribute
      @@delimeters = {:class => " "}
      def initialize name, values
        @name = name.to_s
        @values = values.to_s.split(delimeter)
      end
      
      def removeValue value
        @values.delete(value)
      end
    
      def addValue value
        @values.delete(value)
        @values.push(value)
      end
      
      def values= values
        values.split(delimeter).each do |value|
          addValue(value)
        end
      end
    
      def setValues value
        @values = [value]
      end
      
      def replaceValue from, to
        if i = @values.index(from)
          @values.fill(to,i,1)
        end
      end
    
      def getValues
        @values
      end
      
      def values
        @values.join(delimeter)
      end
    
      def to_s
        @name + '="' + values + '"'
      end
      
      private
      
      def delimeter
        (@@delimeters.values_at(@name.to_sym).first||"; ").to_s
      end
      
    end
  
    class Table < Element
      attr_accessor :column_size
      def initialize *headers
        setHeaders(headers)
        @cells = []
        @column_size = 0
        super "table"
      end
      
      def setHeaders *headers
        @headers = headers.collect {|title| Th.new(title) }
        return @headers
      end
    
      def setColumnSize size=1
        @column_size = size
      end
    
      def << content=nil
        return addCell(content)
      end
    
      def addCell content="&nbsp;"
        cell = Td.new(content)
        @cells << cell
        return cell
      end
    
      def cell
        addCell(yield)
      end
    
      def to_s
        to_table.tagify
      end
    
      def to_table
        calculateColumnSize()
        #@children = []
        unless @headers.empty?
          @thead = Thead.new
          @row = Tr.new
          @headers.each do |header|
            @row.addChildNode(header)
          end
          @thead.addChildNode(@row)
          self.addChildNode(@thead)
        end
        @tbody = Tbody.new
        @cells.each_with_index do |cell, index|
          @row = Tr.new if new_row?(index)
          @row.addChildNode(cell)
          @tbody.addChildNode(@row) if new_row?(index)
        end
        self.addChildNode(@tbody)
        return self
      end
    
      private
      
      def calculateColumnSize
        return @column_size if @column_size > 0
        @headers.each do |h|
          size = (colspan = h.getAttribute(:colspan)) ? colspan.value.to_i : 1
          @column_size += size
        end
        setColumnSize if @column_size==0
      end
        
      def new_row? index
        index % @column_size == 0
      end
    end
  
    class Tr < Element
      def initialize *arg
        super "tr", arg
      end
    end
  
    class Th < Element
      def initialize *arg
        super "th", arg
      end
    end
  
    class Td < Element
      def initialize *arg
        super "td", arg
      end
    end
    
    class Tbody < Element
      def initialize *arg
        super "tbody", arg
      end
    end
    
    class Thead < Element
      def initialize *arg
        super "thead", arg
      end
    end
    
  end
  
  class Button
    attr_accessor :name, :html_options, :containor, :empty
    def initialize(name="", html_options={})
      @name = name
      @html_options = html_options
      @empty = true
      @body = "<sx:i>&nbsp;</sx:i><sx:l><sx:p>&nbsp;</sx:p></sx:l><sx:r><sx:p>&nbsp;</sx:p></sx:r>"
      @tmp = Stixy::Html::Element.new("__temp__")
      if @html_options and @button = @html_options.delete(:button)
        @containor = Stixy::Html::Element.new("sx:button")
        @containor.attributes = @html_options
        @tmp.addAttribute(:class, "button-label") 
        @containor.addAttribute(:class, @button[:type]) if @button[:type]
        @empty = false
        return true
      end
    end
    def attributes
      @tmp.attributes.to_h
    end
    def body
      @body
    end
    def content
      @containor.to_s
    end
    def content= value=""
      @containor.content = value
    end
    def title
      @title.to_s
    end
    def title= value=""
      @title = Stixy::Html::Element.new("sx:t")
      @title.content = value
    end
  end
  

  class Calendar
    attr_accessor :dates, :day_names, :first_weekday, :last_weekday, :start, :stop, :year, :month, :day, :view
    def initialize date=Date.new.year, view = :month, start_week=1
      start_week = start_week==0 ? 1 : 0
      @day = date.day 
      @month = date.month 
      @year = date.year 
      @day_names = Date::DAYNAMES.dup
      @start = Date.civil(@year, @month, 1)
      start_offset = (@start.wday - start_week)
      @start -= start_offset >= 0 ? start_offset : 6
      @stop = Date.civil(@year, @month, -1)
      @view = view.to_sym if view
      case @view
      when :day
        @start = date
        @stop = date
      when :week
        @stop = @start + 6
      when :year
        @start = Date.civil(@year, 1, 1)
        @stop = Date.civil(@year, 12, 31)
      else
        @stop += (6 - @stop.wday + start_week)
      end
      setStartDay(start_week)
      @dates = []
      @start.upto(@stop) do |d|
        times = []
        48.times do |n|
          times << CalendarTime.new(n.to_f/2,d)
        end
        @dates << CalendarDate.new(d,@month,@year,@first_weekday,@last_weekday,times)
      end
    end
    
    def includes? date=Date.now
      date >= @start and date <= @stop
    end
    
    def previous view = :month
      case view.to_sym
      when :day : Date.civil(self.year,self.month,self.day) - 1
      when :week : Date.civil(self.year,self.month,self.day) - 7
      when :year : Date.civil(self.year-1, self.month, self.day)
      else Date.civil(self.year,self.month,+1) - 1
      end
    end
    
    def next view = :month
      case view.to_sym
      when :day : Date.civil(self.year,self.month,self.day) + 1
      when :week : Date.civil(self.year,self.month,self.day) + 7
      when :year : Date.civil(self.year+1, self.month, self.day)
      else Date.civil(self.year,self.month,-1) + 1
      end
    end
  
    def setStartDay start_week=0
      @first_weekday = start_week
      @last_weekday = start_week-1>=0 ? start_week-1: start_week==0 ? 6 : 0
      offsetDays(@day_names)
    end
    
    def offsetDays days
      @first_weekday.times do
        days.push(days.shift)
      end
      return days
    end
    
    def showTime?
      @view == :day || @view == :week
    end
    
    def to_html_table options={}, &block
      table = Html::Table.new(*day_names)
      (showTime? ? 48 : 1).times do |time|
        dates.each do |date|
          cell = table.addCell
          spacer = Html::Element.new("div")
          spacer.addAttribute(:class, "day-height")
          cell.addChildNode(spacer)
          cell.addAttribute(:class, "calendar-day")
          cell.addAttribute(:class, "calendar-other-month") if date.other_month?
          cell.addAttribute(:class, "calendar-today-day") if date.today?
          #cell.addAttribute(:class, "calendar-now") if date.times? and date.time.now?
          cell.addAttribute(:class, "calendar-first-day-of-week") if date.first_weekday?
          cell.addAttribute(:class, "calendar-last-day-of-week") if date.last_weekday?
          cell.addAttribute(:class, "calendar-weekend-day") if date.weekend?
          cell.setAttribute(:id, "#{date.day.year}-#{Date::MONTHNAMES[date.day.month]}-#{Date::DAYNAMES[date.day.wday]}-#{date.day.day}")
          if block_given?
            block.call(date, date.day, date.time(time), cell)
          else
            cell.content = date.day
          end
        end
      end
      table.setAttribute(:class, "calendar")
      table.setAttribute(:border, "0")
      table.setAttribute(:cellspacing, "0")
      table.setAttribute(:cellpadding, "0")
      return table
    end
    
  
    class CalendarDate
      attr :day, :times
    
      def initialize day,month,year,start_week,last_weekday,times
        @day = day
        @month = month 
        @year = year 
        @first_weekday = start_week
        @last_weekday = last_weekday
        @times = times
      end
      
      def time index
        @times[index].time
      end
      
      def times?
        !@times.empty?
      end
          
      def first_weekday?
         @day.wday == @first_weekday
      end
  
      def last_weekday?
        @day.wday == @last_weekday
      end
      
      def end_of_week
        @day + (6 - offset_weekday)
      end
  
      def start_of_week
        @day - offset_weekday
      end
  
      def other_month?
        @day.month != @month
      end
  
      def weekend?
        [0, 6].include?(@day.wday) 
      end
      
      def offset_weekday
        offset = @day.wday - @first_weekday
        offset = 6 if offset < 0
        return offset
      end
  
      def today?
        @day == Date.today
      end
    end
    
    class CalendarTime
      attr :time
    
      def initialize time, date
        @start = Time.local(date.year,date.month,date.day,time.to_i,(time % 1 * 60).to_i)
        @stop = @start + (30*60)
        @time = @start
      end
      
      def first?
        @start.hour == 0 && @start.min == 0
      end
      
      def last?
        @stop.day != @start.day
      end
      
      def now?
        false
      end
    end
    
    class Event
      attr_accessor :start, :stop
      attr_reader :object
      def initialize start, stop, object
        @start = start
        @stop = stop
        @object = object
      end
      
      def multi_day_event?
        !compare_dates(@start, @stop)
      end

      #def event_first_week?
      #  #compare_dates(@start, @date) || compare_dates(@start, @calendar_day.start_of_week){|left, right| left  >= right }
      #end
      #
      #def event_last_week?
      #  compare_dates(@event.stop, @date) || compare_dates(@event.stop, @calendar_day.end_of_week){|left, right| left <= right }
      #end
      #
      #def event_middle_week?
      #  !compare_dates(@event.start, @date) and !compare_dates(@event.stop, @date)
      #end
      #
      #def event_last_day?
      #  compare_dates(@event.stop, @date) || compare_dates(@event.stop, event_end_of_week){|left, right| left <= right }
      #end
      #
      #def event_start_of_week
      #  if compare_dates(@event.start,  @calendar_day.start_of_week){|left, right| left >= right }
      #    return @event.start
      #  else
      #    return  @calendar_day.start_of_week
      #  end
      #end
      #
      #def event_end_of_week
      #  if compare_dates(@event.stop, @calendar_day.end_of_week){|left, right| left <= right }
      #    return @event.stop
      #  else
      #    return @calendar_day.end_of_week
      #  end
      #end
      
      private
      
      def compare_dates left=Time.now, right=Time.now
        left = left.class == Date ? left : Date.parse(left.to_s)
        right = right.class == Date ? right : Date.parse(right.to_s)
        return yield(left, right) if block_given?
        return left == right
      end
      
    end
    
    
  
  end
    
  class TimeFormat
    NUMERIC_DATE_FORMATS_NAMES  = [ "31/12/2008", "31/12/08", "12/31/2008", "12/31/08", "2008/12/31", "08/12/31" ]
    NUMERIC_DATE_FORMATS_VALUES = [ "%d/%m/%Y", "%d/%m/%y", "%m/%d/%Y", "%m/%d/%y", "%Y/%m/%d", "%y/%m/%d" ]
    NUMERIC_DATE_SEPARATORS = %w{ . / - }
    LONG_DATE_FORMATS_NAMES  = [ "December 31, 2007", "31 December 2007" ]
    LONG_DATE_FORMATS_VALUES = [ "%B %d, %Y", "%d %B %Y" ]
    ABBR_DATE_FORMATS_NAMES  = [ "Dec 31, 2007", "31 Dec 2007" ]
    ABBR_DATE_FORMATS_VALUES = [ "%b %d, %Y", "%d %b %Y" ]
    TIME_FORMATS_NAMES  = [ "13:00", "01:00 PM" ]
    TIME_FORMATS_VALUES = [ "%H:%M", "%I:%M %p" ]
    TIME_FORMATS_HOUR = [ "%H", "%I" ]
    TIME_FORMATS_POSTFIX = [ nil, "%p" ]
    
    
    def initialize values=nil
      from_s(values)
    end
    
    def from_s values=nil
      values ||= "n2s1d0t1w0o0"
      @numeric_date, @date_separator, @long_date, @abbr_date, @time, @week, @offset = values[1,1].to_i, values[3,1].to_i, values[5,1].to_i, values[5,1].to_i, values[7,1].to_i, values[9,1].to_i, values[11,1].to_i
      @numeric_date_formats_names  = NUMERIC_DATE_FORMATS_NAMES[@numeric_date]
      @numeric_date_formats_values = NUMERIC_DATE_FORMATS_VALUES[@numeric_date]
      @numeric_date_separators     = NUMERIC_DATE_SEPARATORS[@date_separator]
      @long_date_formats_names     = LONG_DATE_FORMATS_NAMES[@long_date]
      @long_date_formats_values    = LONG_DATE_FORMATS_VALUES[@long_date]
      @abbr_date_formats_names     = ABBR_DATE_FORMATS_NAMES[@abbr_date]
      @abbr_date_formats_values    = ABBR_DATE_FORMATS_VALUES[@abbr_date]
      @time_formats_names          = TIME_FORMATS_NAMES[@time]
      @time_formats_values         = TIME_FORMATS_VALUES[@time]
      @time_formats_hour           = TIME_FORMATS_HOUR[@time]
      @time_formats_postfix        = TIME_FORMATS_POSTFIX[@time]
    end
    
    def date value=0
    end
    
    def get_numeric_date
      { :name => @numeric_date_formats_names, :value => @numeric_date_formats_values }
    end
    
    def get_long_date
      { :name => @long_date_formats_names, :value => @long_date_formats_values }
    end
    
    def get_abbr_date
      { :name => @abbr_date_formats_names, :value => @abbr_date_formats_values }
    end
    
    def get_time
      { :name => @time_formats_names, :value => @time_formats_values  }
    end
    
    def to_numeric_date time = Time.now
      time.strftime(@numeric_date_formats_values.gsub("/",@numeric_date_separators))
    end
    
    def to_long_date time = Time.now
      time.strftime(@long_date_formats_values)
    end
    
    def to_time time = Time.now
      time.strftime(@time_formats_values)
    end
    
    def time time = Time.now
      { :hour => time.strftime(@time_formats_hour), :minute => time.min, :postfix => (twelve_hour_clock? ? time.strftime(@time_formats_postfix) : nil) }
    end
    
    def twelve_hour_clock?
      @time == 1
    end
    
    def week?
      @week == 1
    end
    
    def set args={}
      args.each do |key,value| 
        self.instance_variable_set(("@#{key.to_s}").to_sym, value)
      end
    end
    
    def get value
      self.instance_variable_get(("@#{value.to_s}").to_sym)
    end
    
    def to_s
      "n#{@numeric_date}s#{@date_separator}d#{@long_date}t#{@time}w#{@week}o#{@offset}"
    end

  end
  
  class UserAgent

    def initialize(user_agent)
      @user_agent = user_agent.downcase
    end
    
    def platform
      if @user_agent =~ /win/
        "Windows"
      elsif @user_agent =~ /mac os x/
        "Mac OS X"
      elsif @user_agent =~ /Mac/i
        "Mac"
      elsif @user_agent =~ /ubuntu/
        "Ubuntu Linux"
      elsif @user_agent =~ /linux/
        "Linux"
      elsif @user_agent =~ /sunos/
        "Sun Solaris"
      elsif @user_agent =~ /bsd/
        "FreeBSD"
      elsif @user_agent =~ /gentoo/
        "Gentoo"
      else
        "Other"
      end
    end
    
    def browser
      if @user_agent =~ /gecko/ && gecko_version?
       "Firefox " + @user_agent.scan(/[Firefox].\/(\d.+)/i).to_s
      elsif @user_agent =~ /msie 7/
        "Internet Explorer 7"
      elsif @user_agent =~ /msie 6/
        "Internet Explorer 6"
      elsif @user_agent =~ /msie 5/
        "Internet Explorer 5"
      elsif @user_agent =~ /msie 5.5/
        "Internet Explorer 5.5"
      elsif @user_agent =~ /safari/
        "Safari"
      else
        "Unsupported browser"
      end
    end
    
    private 
    def gecko_version?
    	if @user_agent =~ /rv:/
			  agent = @user_agent.split("rv:")[1]
			  version = agent.slice(0,3)
			  #Check if the version is 1.8 or higher
			  if version >= "1.8"
				  true 
			  else 
				  false
			  end
    	end
    end

  end
  
  
end
