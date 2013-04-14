module DatetimeHelper
  def format_month(date)
    date.strftime("%B %Y")
  end

  def format_datetime(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def format_comment_date(date)
    format_post_date(date) + " at " + date.strftime("%l:%M %p")
  end
end
