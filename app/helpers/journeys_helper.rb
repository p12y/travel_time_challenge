module JourneysHelper
  def meeting_time(start_time:, travel_time:)
    (start_time + travel_time.minutes).strftime('%I:%M %p')
  end
end
