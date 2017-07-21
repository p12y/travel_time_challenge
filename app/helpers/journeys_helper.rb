module JourneysHelper
  def journey_time(journey)
    start_time = journey.start_time
    end_time = journey.meetings.last.departure_time
    distance_of_time_in_words(end_time - start_time)
  end

  def format_time(time)
    time.strftime('%I:%M %p')
  end
end
