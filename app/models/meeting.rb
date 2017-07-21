class Meeting < ApplicationRecord

  belongs_to :journey

  validates :location, presence: true
  validates_numericality_of :duration, allow_blank: true
  validates :name, presence: true
  validates :duration, presence: true

  before_save :calculate_travel_time

  def next
    self.journey.meetings.where("id > ?", self.id).first
  end

  def previous
    self.journey.meetings.where("id < ?", self.id).last
  end

  def durations
    arr = []
    (0..1435).step(5) do |num|
      time = Time.at(num * 60).utc.strftime("%H:%M")
      arr.push([time, num])
    end
    arr
  end

  private

    def calculate_travel_time
      # Set id to allow next/previous methods to work if new record
      if Meeting.count != 0
        id = id || Meeting.last.id + 1
        else
        id = 1
      end

      @start_coords = '51.5199586,-0.0984249' # Rentify coordinates
      @departure_time = self.journey.start_time
      @start_time = self.journey.start_time
      @end_coords = get_coord(self.location)

      if self.previous
        @start_coords = get_coord(self.previous.location)
        @departure_time = self.previous.departure_time
        @start_time = self.previous.departure_time
      end

      #@url = URI.parse("https://developer.citymapper.com/api/1/traveltime/?startcoord=#{@start_coords}&endcoord=#{@end_coords}&time=#{@start_time}&time_type=arrival&key=fcb9f0259d60e4b753865645b6f6f36a")
      #@req = Net::HTTP.get(@url)
      #@res = JSON.parse(@req)

      #if @res["error_message"]
      #  self.journey.errors.add(:request, @res["error_message"])
      #  throw :abort
      #end
      
      #@travel_time = @ret["travel_time_minutes"]
      self.travel_time = 10

      self.arrival_time = @departure_time + self.travel_time.minutes
      self.departure_time = self.arrival_time

      if self.duration
        self.departure_time += self.duration.minutes
      end
    end

    def get_coord(code)
      url = URI.parse("http://maps.googleapis.com/maps/api/geocode/json?address=#{code}&sensor=false")
      req = Net::HTTP.get(url)
      json = JSON.parse(req)

      # Validate location is a London address
      london = false
      json["results"][0]["address_components"].each do |node|
        if node["long_name"] == "London"
          london = true
        end
      end
      if london == false
        self.journey.errors.add(:location, "must be a London address")
        throw :abort
      end

      lat = json["results"][0]["geometry"]["location"]["lat"]
      lng = json["results"][0]["geometry"]["location"]["lng"]
      coord = "#{lat},#{lng}"
    end
end
