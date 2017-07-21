class Meeting < ApplicationRecord

  belongs_to :journey

  validates :postcode, presence: true
  validates_numericality_of :duration, allow_blank: true
  validates :name, presence: true

  before_save :calculate_travel_time

  def next
    self.journey.meetings.order("created_at").where("created_at > ?", Time.current).first
  end

  def previous
    self.journey.meetings.order("created_at").where("created_at < ?", Time.current).first
  end

  private

    def calculate_travel_time
      puts start_coords = self.previous ? get_coord(self.previous.postcode) : '51.5199586,-0.0984249'
      puts end_coords = get_coord(self.postcode)
      puts url = URI.parse("https://developer.citymapper.com/api/1/traveltime/?startcoord=#{start_coords}&endcoord=#{end_coords}&time=2014-11-06T19%3A00%3A02-0500&time_type=arrival&key=fcb9f0259d60e4b753865645b6f6f36a")
      puts req = Net::HTTP.get(url)
      travel_time = JSON.parse(req)["travel_time_minutes"]
      puts self.travel_time = travel_time
    end

    def get_coord(code)
      url = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{code}&sensor=false")
      req = Net::HTTP.get(url)
      lat = JSON.parse(req)["results"][0]["geometry"]["location"]["lat"]
      lng = JSON.parse(req)["results"][0]["geometry"]["location"]["lng"]
      coord = "#{lat},#{lng}"
    end
end
