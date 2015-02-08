require 'dynamic_fetch'

Sidekiq.options.merge!({
    fetch: DynamicFetch
})

Sidekiq.configure_server do |config|
  #Sidekiq::Logging.logger = LoggerCreator.build :sidekiq
  config.redis = Secrets.sidekiq.redis.symbolize_keys 
  config.error_handlers << Proc.new {|ex,context| Bugsnag.notify(ex, context) }
  config.failures_max_count = 50000
  config.failures_default_mode = :exhausted

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 12.hours
  end
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.configure_client do |config|
  config.redis = Secrets.sidekiq.redis.symbolize_keys 
  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

Sidekiq.default_worker_options = { 'backtrace' => true }

if Rails.env.test? # || Rails.env.development?
  require 'sidekiq/testing/inline'
  Sidekiq::Testing.inline!
end

SidekiqUniqueJobs.config.unique_args_enabled = true
