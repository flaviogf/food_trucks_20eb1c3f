# frozen_string_literal: true

require 'csv'

class FoodTrucksHttpService
  FILE_URI = URI('https://data.sfgov.org/api/views/rqzj-sfat/rows.csv?accessType=DOWNLOAD')

  def each_slice(batch, &block)
    fetch_data do |data|
      CSV.new(data, headers: true).each_slice(batch) do |rows|
        block.call(rows.collect(&method(:food_truck_from)))
      end
    end
  end

  private

  def fetch_data(&block)
    Net::HTTP.get_response(FILE_URI) { |resp| resp.read_body(&block) }
  end

  def food_truck_from(row)
    FoodTruck.new(food_items: row['FoodItems'], longitude: row['Longitude'], latitude: row['Latitude'])
  end
end
