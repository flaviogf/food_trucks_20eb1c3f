# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksElasticsearchRepository do
  describe '#search' do
    subject(:food_trucks_elasticsearch_repository) do
      FoodTrucksElasticsearchRepository.new(client: client)
    end

    let(:client) do
      double('client')
    end

    let(:query) do
      {
        index: 'food-trucks-v1',
        body: {
          query: {
            bool: {
              must: [
                {
                  match_all: {}
                }
              ],
              filter: [
                {
                  geo_distance: {
                    distance: '15km',
                    location: {
                      lat: 0,
                      lon: 0
                    }
                  }
                }
              ]
            }
          }
        }
      }
    end

    let(:response) do
      {
        'took' => 4,
        'timed_out' => false,
        '_shards' => {
          'total' => 1,
          'successful' => 1,
          'skipped' => 0,
          'failed' => 0
        },
        'hits' => {
          'total' => {
            'value' => 49,
            'relation' => 'eq'
          },
          'max_score' => 1.0,
          'hits' => [
            {
              '_index' => 'food-trucks-v1',
              '_type' => '_doc',
              '_id' => 'ETvltXoBCPNGK0l2AG18',
              '_score' => 1.0,
              '_source' => {
                'food_items' => 'Filipino fusion food: tacos: burritos: nachos: rice plates. Various beverages.',
                'location' => {
                  'lon' => '0',
                  'lat' => '0'
                }
              }
            }
          ]
        }
      }
    end

    let(:food_truck) do
      build(:food_truck,
            food_items: 'Filipino fusion food: tacos: burritos: nachos: rice plates. Various beverages.',
            longitude: 0,
            latitude: 0)
    end

    before do
      allow(client).to receive(:search).and_return(response)
    end

    it do
      expect(client).to receive(:search).with(query).once

      food_trucks_elasticsearch_repository.search(longitude: 0, latitude: 0)
    end

    it do
      result = food_trucks_elasticsearch_repository.search(longitude: 0, latitude: 0)

      expect(result).to eq([food_truck])
    end
  end

  describe '#insert_all' do
    subject(:food_trucks_elasticsearch_repository) do
      FoodTrucksElasticsearchRepository.new(client: client)
    end

    let(:client) do
      double('client')
    end

    let(:food_trucks) do
      (0..5).collect { build(:food_truck) }
    end

    let(:food_truck_hashes) do
      food_trucks.collect { |food_truck| { index: { _index: 'food-trucks-v1', data: food_truck.to_h } } }
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
      subject(:food_trucks_elasticsearch_repository) do
        FoodTrucksElasticsearchRepository.new(client: client)
      end

      let(:hits) do
        (0..5).collect { |id| { '_id' => id } }
      end

      let(:food_truck_hashes) do
        (0..5).collect { |id| { delete: { _index: 'food-trucks-v1', _id: id } } }
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
