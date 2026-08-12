class AssemblyLine
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    nominal_speed = @speed * 221
    if @speed < 5
      return nominal_speed
    elsif @speed < 9
      return nominal_speed * 0.9
    elsif @speed == 9
      return nominal_speed * 0.8
    else
      return nominal_speed * 0.77
    end
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end

end
