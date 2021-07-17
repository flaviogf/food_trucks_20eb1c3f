# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapsController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    it { expect(response).to have_http_status(:success) }
  end
end
