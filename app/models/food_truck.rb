# frozen_string_literal: true

class FoodTruck
  include ActiveModel::Model

  validates :food_items, presence: true

  validates :longitude, presence: true

  validates :latitude, presence: true

  attr_accessor :food_items, :longitude, :latitude

  def initialize(food_items: '', latitude: 0, longitude: 0)
    @food_items = food_items
    @longitude = longitude
    @latitude = latitude
  end

  def location=(location)
    @longitude = location.longitude
    @latitude = location.latitude
  end

  def location
    Location.new(longitude: longitude, latitude: latitude)
  end

  def to_h
    {
      food_items: food_items,
      location: {
        lon: longitude,
        lat: latitude
      }
    }
  end
end
