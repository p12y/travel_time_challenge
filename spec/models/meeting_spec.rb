require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it {should validate_presence_of :location}
  it {should validate_presence_of :duration}
  it {should validate_presence_of :name}
  it {should validate_numericality_of :duration}

  it {should belong_to :journey}

  it "has a factory" do
    expect(FactoryGirl.factories.registered?(:meeting)).to be true
  end


  it "finds next record" do
    create(:journey_with_meetings)
    expect(Meeting.first.next.id).to eq Meeting.second.id
  end

  it "finds previous record" do
    create(:journey_with_meetings)
    expect(Meeting.last.previous.id).to eq Meeting.first.id
  end

  it "generates array of durations" do
    create(:journey_with_meetings)
    expect(Meeting.first.durations.first).to eq ["00:00", 0]
    expect(Meeting.first.durations.last).to eq ["23:55", 1435]
  end

end
