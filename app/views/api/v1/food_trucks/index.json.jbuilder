# frozen_string_literal: true

json.array! @food_trucks do |food_truck|
  json.food_items food_truck.food_items
  json.longitude food_truck.longitude
  json.latitude food_truck.latitude
end
