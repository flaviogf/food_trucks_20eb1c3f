# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksElasticsearchRepository do
  describe '#insert_all' do
    let(:client) do
      double('client')
    end

    let(:food_trucks) do
      (0..5).collect { build(:food_truck) }
    end

    let(:food_truck_hashes) do
      food_trucks.collect { |food_truck| { index: { _index: 'food-trucks-v1', data: food_truck.to_h } } }
    end

    subject(:food_trucks_elasticsearch_repository) do
      FoodTrucksElasticsearchRepository.new(client: client)
    end

    before do
      allow(client).to receive(:bulk)
    end

    after do
      food_trucks_elasticsearch_repository.insert_all(food_trucks)
    end

    it { expect(client).to receive(:bulk).with(body: food_truck_hashes).once }
  end

  describe '#delete_all!' do
    let(:client) do
      double('client')
    end

    context 'when count is positive' do
      let(:hits) do
        (0..5).collect { |id| { '_id' => id } }
      end

      let(:food_truck_hashes) do
        (0..5).collect { |id| { delete: { _index: 'food-trucks-v1', _id: id } } }
      end

      subject(:food_trucks_elasticsearch_repository) do
        FoodTrucksElasticsearchRepository.new(client: client)
      end

      before do
        allow(client).to receive(:count).and_return({ 'count' => hits.count })
        allow(client).to receive(:search).and_return({ 'hits' => { 'hits' => hits } })
        allow(client).to receive(:bulk)
      end

      after do
        food_trucks_elasticsearch_repository.delete_all!
      end

      it { expect(client).to receive(:bulk).with(body: food_truck_hashes).once }
    end

    context 'when count is not positive' do
      subject(:food_trucks_elasticsearch_repository) do
        FoodTrucksElasticsearchRepository.new(client: client)
      end

      before do
        allow(client).to receive(:count).and_return({ 'count' => 0 })
        allow(client).to receive(:search).and_return({ 'hits' => { 'hits' => [] } })
        allow(client).to receive(:bulk)
      end

      after do
        food_trucks_elasticsearch_repository.delete_all!
      end

      it { expect(client).to_not receive(:bulk) }
    end
  end
end
