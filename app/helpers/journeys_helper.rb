module JourneysHelper
  def journey_time(journey)
    output = ""
    if journey.meetings.any?
      start_time = journey.start_time
      end_time = journey.meetings.last.departure_time
      output = distance_of_time_in_words(end_time - start_time)
    end
    output
  end

  def format_time(time)
    time.strftime('%I:%M %p')
  end
end
