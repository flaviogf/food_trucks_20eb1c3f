# frozen_string_literal: true

class FoodTrucksElasticsearchRepository
  def initialize(client: Elasticsearch::Client.new(host: 'elasticsearch:9200'))
    @client = client
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
end
