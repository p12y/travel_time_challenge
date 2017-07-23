FactoryGirl.define do
  factory :journey do
    start_time "2017-07-21 22:26:21"
    name "Journey1"
    start_date "2017-07-21"

    factory :journey_with_meetings do
      before(:create) { Meeting.skip_callback(:save, :before, :calculate_travel_time) }
      after(:create) { Meeting.set_callback(:save, :before, :calculate_travel_time) }
      before(:create) do |journey|
        journey.meetings << build_list(:meeting, 2, journey: journey)
      end
    end
  end
end
