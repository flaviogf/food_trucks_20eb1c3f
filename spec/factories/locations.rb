# frozen_string_literal: true

FactoryBot.define do
  factory :location do
    longitude { 1 }
    latitude { 1 }

    initialize_with { new(longitude: longitude, latitude: latitude) }
  end
end
