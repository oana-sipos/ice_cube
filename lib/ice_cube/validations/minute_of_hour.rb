module MinuteOfHourValidation
  
  def minute_of_hour(*minutes)
    @minutes_of_hour ||= []
    minutes.each do |minute|
      raise ArgumentError.new('Argument must be a valid minute') unless minute < 60 && minute >= 0
      @minutes_of_hour << minute
    end
    self
  end
  
  def validate_minute_of_hour(date)
    return true if !@minutes_of_hour || @minutes_of_hour.empty?
    @minutes_of_hour.include?(date.min)
  end
  
  def closest_minute_of_hour(date)
    return nil if !@minutes_of_hour || @minutes_of_hour.empty?
    # turn minutes into minutes of hour
    # minute >= 60 should fall into the next hour
    minutes = @minutes_of_hour.map do |m|
      m > date.min ? m - date.min : 60 - date.min + m
    end
    minutes.compact!
    # go to the closest distance away, the beginning of that minute
    closest_minute = minutes.min
    goal = date + closest_minute * 60
  end
  
end