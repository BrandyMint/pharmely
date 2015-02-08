class LongWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker 

  def perform id
    Rails.logger.info "Run LongWork with #{id}"
    sleep 120
  end
end

