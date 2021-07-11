# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksElasticsearchRepository do
  describe '#bulk' do
    let(:client) do
      double('client')
    end

    let(:food_trucks) do
      (0..5).collect { build(:food_truck) }
    end

    let(:food_truck_hashs) do
      food_trucks.collect { |food_truck| { index: { _index: 'food-trucks-v1', data: food_truck.to_h } } }
    end

    subject(:food_trucks_elasticsearch_repository) do
      FoodTrucksElasticsearchRepository.new(client: client)
    end

    before do
      allow(client).to receive(:bulk)
    end

    after do
      food_trucks_elasticsearch_repository.bulk(food_trucks)
    end

    it { expect(client).to receive(:bulk).with(body: food_truck_hashs).once }
  end
end
