class PriceList < ActiveRecord::Base
  extend Enumerize

  mount_uploader :file, PriceListUploader

  belongs_to :pharmacy

  scope :ordered, -> { order 'id desc' }

  enumerize :state, in: [:queued, :importing, :done], default: :queued

  validates :file, presence: true

  after_commit :import_file, on: :create

  def importing!
    update_attribute :state, :importing
  end

  def done!
    update_attribute :state, :done
  end

  def filename
    file.file.filename
  end

  def job_status
    job['status']
  rescue
    '-'
  end

  def job
    Sidekiq::Status::get_all job_id if job_id.present?
  end

  private

  def queue_name
    "pharmacy-#{pharmacy_id}"
  end

  def import_file
    update_column :job_id, Sidekiq::Client.push(
      'queue' => queue_name, 
      'class' => DrugsImportWorker, 
      'args' => [pharmacy_id, id]
    )
    raise "Задача по импорту не поставлена. Очевидно выполняется другая" unless job_id.present?
  end

end
