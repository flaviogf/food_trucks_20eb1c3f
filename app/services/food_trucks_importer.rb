# frozen_string_literal: true

class FoodTrucksImporter
  def initialize(service:, repository:)
    @service = service
    @repository = repository
  end

  def execute
    @service.each_slice(50) { |food_trucks| @repository.bulk(food_trucks) }
  end
end
