# frozen_string_literal: true

class FoodTrucksImporter
  def initialize(service: FoodTrucksHttpService.new, repository: FoodTrucksElasticsearchRepository.new)
    @service = service
    @repository = repository
  end

  def execute
    @repository.delete_all!

    @service.each_slice(50) { |food_trucks| @repository.insert_all(food_trucks) }
  end
end
