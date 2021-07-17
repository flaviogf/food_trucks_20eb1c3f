# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'maps#index'

  namespace :api do
    namespace :v1 do
      resources :food_trucks
    end
  end

  resources :maps
end
