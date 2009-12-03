# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def reformat_time time
    # Pick the right translation format
    formated = if time.hour.to_i == 0
      if time.min.to_i == 1
        l(time, :format => :longtime_one_minute)
      else
        l(time, :format => :longtime_other_minutes)
      end
    elsif time.hour.to_i == 1
      if time.min.to_i == 0
        l(time, :format => :longtime_one_hour)
      elsif time.min.to_i == 1
        l(time, :format => :longtime_one_hour_one_minute)
      else
        l(time, :format => :longtime_one_hour_other_minutes)
      end
    else
      if time.min.to_i == 0
        l(time, :format => :longtime_other_hours)
      elsif time.min.to_i == 1
        l(time, :format => :longtime_other_hours_one_minute)
      else
        l(time, :format => :longtime_other_hours_other_minutes)
      end
    end
    # Remove all preceding zeros
    formated.gsub(/\d+/){|m| m.map{|d| d.to_i }}
  end
end

