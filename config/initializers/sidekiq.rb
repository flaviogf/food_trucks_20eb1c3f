# frozen_string_literal: true

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379/0' }

  Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml')
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379/0' }
end
