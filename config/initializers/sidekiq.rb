# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end

Rails.application.config.after_initialize do
  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
end
