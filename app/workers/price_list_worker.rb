# http://www.rubydoc.info/gems/sidekiq-dynamic-queues/0.6.0
class PriceListWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker 

  #sidekiq_options unique: true,
    #unique_args: ->(args) { [ args.first ] }

  def perform id
    pl = PriceList.find id

    pl.import_drugs self
  rescue ActiveRecord::RecordNotFound
  end

end
