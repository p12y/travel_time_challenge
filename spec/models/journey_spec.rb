require 'rails_helper'

RSpec.describe Journey, type: :model do
  it {should validate_presence_of :start_time}
  it {should validate_presence_of :start_date}
  
  it {should have_many :meetings}
end
