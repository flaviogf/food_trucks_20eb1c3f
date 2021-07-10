# frozen_string_literal: true

class Location
  attr_reader :longitude, :latitude

  def initialize(longitude: 0, latitude: 0)
    @longitude = longitude
    @latitude = latitude
  end

  def ==(other)
    longitude == other.longitude && latitude == other.latitude
  end
end
