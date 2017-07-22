FactoryGirl.define do
  factory :journey do
    start_time "2017-07-21 22:26:21"
    name "Journey1"
    start_date "2017-07-21"

    factory :journey_with_meetings do
      after(:build) { Meeting.skip_callback(:save, :before, :calculate_travel_time) }
      after(:create) { Meeting.set_callback(:save, :before, :calculate_travel_time) }
      after(:build) do |journey|
        2.times { create(:meeting, journey: journey) }
      end
    end
  end
end
