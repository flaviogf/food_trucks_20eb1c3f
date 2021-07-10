# frozen_string_literal: true

class FoodTrucksElasticsearchRepository
  def bulk(food_trucks)
    Rails.logger.info("bulk inserting #{food_trucks.inspect}")
  end
end
