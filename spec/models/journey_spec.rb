require 'rails_helper'

RSpec.describe Journey, type: :model do
  it {should validate_presence_of :start_time}
  it {should validate_presence_of :start_date}
  it {should validate_presence_of :meetings}
  it {should validate_presence_of :name}

  it {should accept_nested_attributes_for :meetings}
  it {should have_many :meetings}

  it "deletes associated record on delete" do
    journey = create(:journey_with_meetings)
    journey.destroy
    expect(Meeting.count).to eq 0
  end
end
