# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::FoodTrucksController, type: :controller do
  describe 'GET #index' do
    let(:repository) do
      double('repository', search: food_trucks)
    end

    let(:food_trucks) do
      (0..5).collect { build(:food_truck) }
    end

    before do
      allow_any_instance_of(Api::V1::FoodTrucksController).to receive(:repository).and_return(repository)
    end

    context 'when longitude and latitude are passed' do
      let(:params) do
        {
          longitude: '0',
          latitude: '0'
        }
      end

      it do
        get :index, params: params
        expect(response).to have_http_status(:success)
      end

      it do
        get :index, params: params
        expect(assigns(:food_trucks)).to eq(food_trucks)
      end
    end

    context 'when longitude is not passed' do
      let(:params) do
        {
          latitude: '0'
        }
      end

      it do
        expect(repository).not_to receive(:search)
        get :index, params: params
      end
    end

    context 'when latitude is not passed' do
      let(:params) do
        {
          longitude: '0'
        }
      end

      it do
        expect(repository).not_to receive(:search)
        get :index, params: params
      end
    end
  end
end
