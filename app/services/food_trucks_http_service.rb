# frozen_string_literal: true

require 'csv'

class FoodTrucksHttpService
  FILE_URI = URI('https://data.sfgov.org/api/views/rqzj-sfat/rows.csv?accessType=DOWNLOAD')

  def each_slice(batch, &block)
    Net::HTTP.get_response(FILE_URI) do |resp|
      CSV.new(resp.body, headers: true).each_slice(batch, &block)
    end
  end
end
