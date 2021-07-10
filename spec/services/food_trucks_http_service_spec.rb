# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksHttpService do
  describe '#each_slice', :vcr do
    subject(:food_trucks_http_service) do
      FoodTrucksHttpService.new
    end

    specify { expect { |block| food_trucks_http_service.each_slice(50, &block) }.to yield_control.exactly(13).times }
  end
end
