# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Location do
  describe '#==' do
    context 'when longitude and latitude are equal' do
      subject do
        build(:location, longitude: 1, latitude: 1)
      end

      let(:other) do
        build(:location, longitude: 1, latitude: 1)
      end

      it { is_expected.to eq(other) }
    end

    context 'when longitude is different' do
      subject do
        build(:location, longitude: 1, latitude: 1)
      end

      let(:other) do
        build(:location, longitude: 2, latitude: 1)
      end

      it { is_expected.to_not eq(other) }
    end

    context 'when latitude is different' do
      subject do
        build(:location, longitude: 1, latitude: 1)
      end

      let(:other) do
        build(:location, longitude: 1, latitude: 2)
      end

      it { is_expected.to_not eq(other) }
    end
  end
end
