# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTruck do
  it { is_expected.to validate_presence_of(:food_items) }

  it { is_expected.to validate_presence_of(:longitude) }

  it { is_expected.to validate_presence_of(:latitude) }

  describe '#location=' do
    let(:food_truck) do
      build(:food_truck)
    end

    before do
      food_truck.location = build(:location, longitude: 2, latitude: 2)
    end

    it { expect(food_truck.location).to eq(build(:location, longitude: 2, latitude: 2)) }
  end

  describe '#location' do
    let(:food_truck) do
      build(:food_truck)
    end

    it { expect(food_truck.location).to eq(build(:location, longitude: 1, latitude: 1)) }
  end

  describe '#to_h' do
    let(:food_truck) do
      build(:food_truck)
    end

    let(:food_truck_hash) do
      {
        food_items: food_truck.food_items,
        location: {
          lon: food_truck.longitude,
          lat: food_truck.latitude
        }
      }
    end

    it { expect(food_truck.to_h).to eq(food_truck_hash) }
  end
end
