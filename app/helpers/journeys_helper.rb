module JourneysHelper
  def journey_time(journey)
    output = ""
    if journey.meetings.any?
      start_time = journey.start_time
      end_time = journey.meetings.last.departure_time
      time = Time.at(end_time - start_time).utc
      hours = time.strftime('%H').to_i
      hour_text = hours > 0 ? pluralize(time.strftime('%H').to_i, 'hour') : nil
      comma = hours > 0 ? "," : nil
      minutes = pluralize(time.strftime('%M').to_i, 'minute')
      output = "#{hour_text}#{comma} #{minutes}"
    end
    output
  end

  def format_time(time)
    time.strftime('%I:%M %p')
  end

  def default_date(start_time)
    start_time ? start_time.strftime('%d/%m/%Y') : Time.current.to_date.strftime('%d/%m/%Y')
  end
end
