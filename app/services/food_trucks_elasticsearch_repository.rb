# frozen_string_literal: true

class FoodTrucksElasticsearchRepository
  def initialize(client: Elasticsearch::Client.new(host: 'elasticsearch:9200'))
    @client = client
  end

  def search(longitude:, latitude:)
    body = {
      query: {
        bool: {
          must: [{ match_all: {} }],
          filter: [{ geo_distance: { distance: '2000m', location: { lat: latitude, lon: longitude } } }]
        }
      }
    }

    @client.search(index: 'food-trucks-v1', body: body).dig('hits', 'hits').collect(&method(:food_truck_from))
  end

  def insert_all(food_trucks)
    body = food_trucks.collect { |food_truck| { index: { _index: 'food-trucks-v1', data: food_truck.to_h } } }

    @client.bulk(body: body)
  end

  def delete_all!
    count = @client.count(index: 'food-trucks-v1')['count']

    return unless count.positive?

    hits = @client.search(index: 'food-trucks-v1', size: count).dig('hits', 'hits')

    food_truck_ids = hits.collect { |hit| hit['_id'] }

    body = food_truck_ids.collect { |id| { delete: { _index: 'food-trucks-v1', _id: id } } }

    @client.bulk(body: body)
  end

  private

  def food_truck_from(hit)
    FoodTruck.new(food_items: hit.dig('_source', 'food_items'),
                  longitude: hit.dig('_source', 'location', 'lon').to_f,
                  latitude: hit.dig('_source', 'location', 'lat').to_f)
  end
end
