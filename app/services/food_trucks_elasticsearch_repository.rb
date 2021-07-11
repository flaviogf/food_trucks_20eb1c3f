# frozen_string_literal: true

class FoodTrucksElasticsearchRepository
  def initialize(client: Elasticsearch::Client.new(host: 'elasticsearch:9200'))
    @client = client
  end

  def bulk(food_trucks)
    body = food_trucks.collect { |food_truck| { index: { _index: 'food-trucks-v1', data: food_truck.to_h } } }

    @client.bulk(body: body)
  end
end
