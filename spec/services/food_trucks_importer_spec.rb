# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FoodTrucksImporter do
  describe '#execute' do
    subject(:food_trucks_importer) do
      FoodTrucksImporter.new(service: service, repository: repository)
    end

    let(:service) do
      double('service')
    end

    let(:repository) do
      double('repository')
    end

    before do
      allow(service).to receive(:each_slice).and_yield([])

      allow(repository).to receive(:delete_all!)

      allow(repository).to receive(:insert_all)
    end

    after do
      food_trucks_importer.execute
    end

    it { expect(service).to receive(:each_slice).with(50).once }

    it { expect(repository).to receive(:delete_all!).once }

    it { expect(repository).to receive(:insert_all).with([]).once }
  end
end
