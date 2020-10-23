Sidekiq.configure_client do |config|
   config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0", namespace: 'ifme' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV['REDIS_HOST']}:#{ENV['REDIS_PORT']}/0", namespace: 'ifme' }
  schedule_file = "config/sidekiq_schedule.yml"

  if File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.default_worker_options = { :backtrace => true, :unique => :all, :failures => true }
