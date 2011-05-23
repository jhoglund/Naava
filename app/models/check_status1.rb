# -*- encoding : utf-8 -*-

class CheckStatus < AbstractCheck
  include Mongoid::Document
  store_in :statusreport
  
  class Details
    
    attr_reader :data, :collection, :starts_at, :ends_at
    
    def initialize data={}, starts_at=0, ends_at=0
      @data = data
      @collection = {}
      @starts_at = starts_at
      @ends_at = ends_at
      build_abstract_agent_collection
    end
    
    def + details
      @data.merge!(details.data)
      @collection.merge!(details.collection)
      self
    end
    
    # Find details for a AbstractAgent
    def find key
      @collection[key]
    end
    
    def as_json options = nil
      @collection.as_json(options)
    end
    
    private
    
    # Populate detail collection
    def build_abstract_agent_collection
      unless @data.nil?
        @data.each do |key, data|
          @collection[key] = AbstractAgent.new(data.reverse, @starts_at, @ends_at)
        end
      end
    end
        
  end
  
  class AbstractAgent
    
    def initialize data={}, starts_at=0, ends_at=0
      @data = data
      @status_collection = {}
      @percentage_collection = []
      @total_status_duration = ends_at-starts_at
      @total_status_business_duration = BusinessHours.new(Time.at(starts_at).utc, Time.at(ends_at).utc).to_i
      build_collections(starts_at, ends_at)
    end
    
    def status type=:up
      @status_collection[type]
    end
    
    def percentage type=:up, hours=:all
      duration = hours==:all ? @total_status_duration : @total_status_business_duration
      return 0 if duration == 0
      ((total(type, hours).to_f / duration.to_f) * 10000) / 100
    end
    
    def availability hours=:all
      percentage(:up, hours) + percentage(:warning, hours)
    end
    
    def downtime hours=:all
      total(:down, hours) + total(:unknown, hours) + total(:error, hours)
    end
    
    def total type=:up, hours=:all
      case hours
      when :non_business then status(type).total(:all) - status(type).total(:non_business)
      when :business then status(type).total(:business)
      else status(type).total(:all)
      end
    end
    
    def as_json options = nil
      {
        #:data                           => @data,
        #:status_collection              => @status_collection,
        :percentage_collection          => @percentage_collection,
        :total_status_duration          => @total_status_duration,
        :total_status_business_duration => @total_status_business_duration
      }.as_json(options)
    end
    
    def to_a
      # [type,left,width]
      @percentage_collection
    end
    
    private
    
    def build_collections starts_at, ends_at
      build_percentages_collection(build_status_collections(starts_at, ends_at), ends_at-starts_at)
    end
    
    def build_status_collections starts_at, ends_at
      %w(up down warning unknown error).each{|type| @status_collection[type.to_sym] = Status.new(type) }
      [].tap do |c|
        @data.each_with_index do |status, i|
          type = status.first.downcase.to_sym
          period_starts_at = i==0 ? starts_at : status.last
          period_ends_at = (@data[i+1]||[ends_at]).last
          c << { :status => type.to_s, :percentage => ((@status_collection[type].add_period(period_starts_at, period_ends_at).duration.to_f * 100) / @total_status_duration) }
        end
      end
    end
    
    def build_percentages_collection c, duration
      sum = 0
      status = nil
      left = nil
      width = nil
      c.each do |item|
        if status == item[:status]
          @percentage_collection.last[:w] = format(width+item[:percentage])
        else
          @percentage_collection << {:s => item[:status], :l => format(sum), :w => format(item[:percentage])}
        end
        width = item[:percentage]
        status = item[:status]
        sum += width
      end
      @percentage_collection.last[:w] = format(100-@percentage_collection.last[:l].to_f)
    end
    
    def format f
      sprintf("%.4f", f)
    end
  end
  
  class Status
    def initialize type
      @periods = []
      @type = type
      @total = 0
      @total_bussiness = 0
    end
    
    def add_period starts_at, ends_at
      period = Period.new(starts_at, ends_at)
      @periods << period
      @total += period.duration
      @total_bussiness += BusinessHours.new(Time.at(starts_at).utc, Time.at(ends_at).utc).to_i
      period
    end
    
    def total hours=:all
      hours==:all ? @total : @total_bussiness
    end
  end
  
  class Period
    attr_reader :starts_at, :ends_at, :duration
    def initialize starts_at, ends_at
      @starts_at = starts_at
      @ends_at = ends_at
      @duration = @ends_at - @starts_at
    end
  end
  
  class BusinessHours
    # Sunday...Saturday
    BUSINESS_HOURS = [10..20, 8..20, 8..20, 8..20, 8..20, 8..20, 10..20]

    def initialize starts_at, ends_at
      offset = starts_at.wday
      days = (to_date(ends_at) - to_date(starts_at)).to_i + 1
      @starts_at = starts_at
      @ends_at = ends_at
      @sum = 0
      days.times do |i|
        business_hours = BUSINESS_HOURS[(offset+i)%7]
        if business_hours
          if days==1
            @sum += end_time(business_hours) - start_time(business_hours)
          elsif i==0
            @sum += hour_to_sec(business_hours.last) - start_time(business_hours)
          elsif i==days-1
            @sum += end_time(business_hours) - hour_to_sec(business_hours.first)
          else
            @sum += hour_to_sec(business_hours.last - business_hours.first)
          end
        end
      end
    end

    def to_i
      @sum
    end

    private
    
    def end_time business_hours
      [[hour_to_sec(business_hours.last), time_to_sec(@ends_at)].min, hour_to_sec(business_hours.first)].max
    end
    
    def start_time business_hours
      [[hour_to_sec(business_hours.first), time_to_sec(@starts_at)].max, hour_to_sec(business_hours.last)].min
    end
    
    def hour_to_sec hour
      hour*(60*60)
    end

    def time_to_sec time
      (time.hour * 60 * 60) + (time.min * 60) + time.sec
    end
    
    def to_date time
      Date.civil(time.year,time.month,time.day)
    end

  end
  
  class << self
    
    def previous_for *ids
      conditions = ids.extract_options!
      account_epoch_offset = conditions.delete(:account_epoch_offset)
      if conditions.include?(:from)
        [].tap do |rows|
          ids.flatten.each do |id|
            where({:_id.gte => to_hex(id).ljust(24,'0'), :_id.lte => to_hex(id, conditions.delete(:from)).ljust(24,'F')}).descending('_id').with_limit_or_not(conditions.delete(:limit)).each do |record|
              if record
                set_epoch_and_key(record, account_epoch_offset)
                record.date = Time.at(record.epoch)
                rows << record
              end
            end
          end
        end
      end
    end
    
    def find_for *ids
      conditions = ids.extract_options!
      account_epoch_offset = conditions.delete(:account_epoch_offset)
      results = abstract_find_for(ids, conditions) do |record|
        set_epoch_and_key(record, account_epoch_offset)
      end
    end
    
    def status_for *ids
      conditions = ids.extract_options!
      results = to_hash(find_for(ids, (conditions||{}).dup)||{}) || {}
      
      # If :from option is set and the timestamp of the last record is greater than the :from option
      # then find the adjecent record previous to the first record and add it to the beginning of the found collection.
      # If :limit is set, remove the first item from the collection, so the total count of records matches the :limit option.
      if conditions[:from]
        results.each do |key, result|
          if result.first.last > conditions[:from].to_i
            if previous = previous_for(key[/\d+/], :from => conditions[:from], :limit => 1) and !previous.empty?
              result << to_status_array(previous.first)
              result.shift
            end
          end
        end
        missing_ids = ids.flatten.dup
        missing_ids.select!{|id| results["_#{id}"].nil? }
        results.merge!(to_hash(find_for(missing_ids, :limit => 1))||{})
      end
      results
    end
    
    def details_for *ids
      conditions = ids.extract_options!
      details_arry = [].tap do |results|
        ids.each do |id|
          cache_key = cache_key('details_for_status', id, conditions[:from].to_i, conditions[:to].to_i)
          if cached_version = Rails.cache.read(cache_key)
            results << cached_version
          else
            Report.benchmark("DATA") do
              @data = self.status_for(ids, conditions.dup)
            end
            Report.benchmark("DETAILS") do
              details = Details.new(@data, conditions[:from].to_i, conditions[:to].to_i)
              Rails.cache.write(cache_key, details)
              results << details
            end
          end
        end
      end
      details_arry.inject{|sum,d| sum + d }
    end
            
    private
    
    def cache_key name, *ids, from, to
      [name, ids.join('_'), from, to].join('-')
    end
         
    def to_hash records=nil
      return nil if records.blank?
      {}.tap do |hash| 
        records.each do |record| 
          (hash[record.key]||=[]) << to_status_array(record)
        end
      end
    end
    
    def to_status_array record
      [(record.status||'error'), record.epoch]
    end
        
  end
  
end
