# frozen_string_literal: true

class FoodTrucksJob < ApplicationJob
  queue_as :default

  def perform(*args)
    FoodTrucksImporter.new.execute(*args)
  end
end
