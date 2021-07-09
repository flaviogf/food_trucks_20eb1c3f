# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksImporter do
  describe '#execute' do
    let(:service) do
      double('service', each_slice: [])
    end

    let(:repository) do
      double('repository', bulk: [])
    end

    subject(:sut) do
      FoodTrucksImporter.new(service: service, repository: repository)
    end

    it 'has to call service#each_slice once' do
      expect(service).to receive(:each_slice).once

      sut.execute
    end

    it 'has to call service#each_slice once with 50' do
      expect(service).to receive(:each_slice).with(50).once

      sut.execute
    end

    it 'has to call repository#bulk once' do
      expect(service).to receive(:each_slice).and_yield([1])

      expect(repository).to receive(:bulk).once

      sut.execute
    end
  end
end
