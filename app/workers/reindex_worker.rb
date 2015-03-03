class ReindexWorker
  include Sidekiq::Worker

  def perform
    DrugsIndex.reset!
  end
end
