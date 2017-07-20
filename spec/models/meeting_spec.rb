require 'rails_helper'

RSpec.describe Meeting, type: :model do
  it {should validate_presence_of :postcode}
  it {should validate_presence_of :duration}
  it {should validate_presence_of :name}

  it {should belong_to :journey}
end
