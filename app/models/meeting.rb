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
        self.id = self.id || Meeting.last.id + 1
        else
        self.id = 1
      end

      @start_coords = '51.5199586,-0.0984249' # Rentify coordinates
      @departure_time = self.journey.start_time
      @start_time = self.journey.start_time
      @start_date = self.journey.start_date
      @end_coords = get_coord(self.location)

      # Set time & coordinates to previous location
      if self.previous
        @start_coords = get_coord(self.previous.location)
        @departure_time = self.previous.departure_time
        @start_time = self.previous.departure_time
      end

      # Combine start_time & start_date - could be handled by gem instead
      @start_time = Time.parse("#{@start_date.to_s} #{@start_time.to_s}") 

      # Send API request
      @uri = URI.parse('https://developer.citymapper.com/api/1/traveltime/')
      @params = { startcoord: @start_coords, endcoord: @end_coords, 
                  time: @start_time, time_type: 'arrival', 
                  key: '1a1fb831e477a3b580de248076775e2d' 
                }
      @uri.query = URI.encode_www_form(@params)
      @res = Net::HTTP.get_response(@uri)

      # Return if not a success
      if !@res.is_a?(Net::HTTPSuccess)
        self.journey.errors.add(:request, "something went wrong")
        throw :abort
      end

      # Parse request
      @json = JSON.parse(@res.body)

      # Return if API returns error
      if @json["error_message"]
        self.journey.errors.add(:request, @json["error_message"])
        throw :abort
      end
      
      # Set departure/arrial time and add meeting duration
      @travel_time = @json["travel_time_minutes"]
      self.travel_time = @travel_time
      self.arrival_time = @departure_time + self.travel_time.minutes
      self.departure_time = self.arrival_time
      self.departure_time += self.duration.minutes
    end

    def get_coord(code)
      # Ensure location is London
      code = "#{code}, london"

      # Make API request
      uri = URI.parse("http://maps.googleapis.com/maps/api/geocode/json")
      params = { address: code, sensor: false }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)

      if res.is_a?(Net::HTTPSuccess)
        json = JSON.parse(res.body)
      else
        self.journey.errors.add(:request, "something went wrong")
        throw :abort
      end

      # Validate returned location is a London address
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
