# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # Capitalizes a string that may include markup
  def capitalize str=''
    str.sub(/(>(.))|(^\w)/){|s| s.upcase }
  end
  
  def asset_path(str='.css')
    return "/#{ case str
    when /\.css$/
      'stylesheets'
    when /\.js$/
      'javascripts'
    else
      'images'
    end }/#{str}"
  end
  
  def include_inline_resource name, type = :javascript, &block
    @inline_resource_cache ||= { :javascript => {},:css => {} }
    unless @inline_resource_cache[type][name]
      @inline_resource_cache[type][name] = capture(&block)
      content_for(type) do
        @inline_resource_cache[type][name]
      end
    end
  end
  
  def include_resource pathes, type = :javascript
    @resource_cache ||= {}
    content_for(:include_resource) do
      returning '' do |str|
        [pathes].flatten.each do |path|
          next if @resource_cache[path]
          @resource_cache[path] = true
          if type == :javascript
            str << javascript_include_tag(path)
          else
            str << stylesheet_link_tag(path)
          end
        end
      end
    end
  end
  
  def include_javascript *path
    return include_resource path, :javascript
  end
  
  def include_stylesheet *path
    include_resource path, :css
  end
  
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
  
  def base_errors_for obj=nil
    unless obj.nil? or obj.errors.on_base.blank?
        %(<div class="base-error">
        #{ obj.errors.on_base.collect { |error| content_tag('div', error, :class => "base-error-item") } }
      </div>)
    end
  end
end

