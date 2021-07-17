# frozen_string_literal: true

module Api
  module V1
    class FoodTrucksController < ApiController
      def index
        @food_trucks = if params[:longitude].present? && params[:latitude].present?
                         repository.search(longitude: params[:longitude], latitude: params[:latitude])
                       else
                         []
                       end
      end

      private

      def repository
        @repository ||= FoodTrucksElasticsearchRepository.new
      end
    end
  end
end
