
module TimeHelper
  def format_time(time)
    time.strftime("%H:%M") if time.is_a?(Time)
  end
end
