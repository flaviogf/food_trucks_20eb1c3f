# frozen_string_literal: true

FactoryBot.define do
  factory :food_truck do
    food_items { 'Chinese' }
    longitude { 1 }
    latitude { 1 }

    initialize_with { new(food_items: food_items, longitude: longitude, latitude: latitude) }
  end
end
