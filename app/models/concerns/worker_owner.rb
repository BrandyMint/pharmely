module WorkerOwner
  extend ActiveSupport::Concern
  included do
    extend Enumerize
    enumerize :state, in: [:queued, :importing, :done], default: :queued
  end
  def job
    Hashie::Mash.new Sidekiq::Status::get_all job_id if job_id.present?
  end

  def import_drugs worker
    start!
    drugs_count, errors_count = ImportService.
      new(pharmacy: pharmacy, 
          worker: worker,
          files: files)
      perform
    update_columns drugs_count: drugs_count, errors_count: errors_count
  ensure
    finish!
  end

  def queue_import
    update_column :job_id, Sidekiq::Client.push(
      'queue' => queue_name, 
      'class' => worker_class,
      'args' => [id]
    )
    raise "Задача по импорту не поставлена. Очевидно выполняется другая" unless job_id.present?
  end

  private

  def start!
    update_attributes! state: :importing, start_at: Time.now
  end

  def finish!
    update_attributes! state: :done, finish_at: Time.now
  end

  def queue_name
    "pharmacy-#{pharmacy_id}"
  end

end
