class LongWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker 

  def perform id
    Sidekiq.logger "Run LongWork with #{id}"
    Rails.logger.info "Run LongWork with #{id}"
    sleep 120
  end
end

