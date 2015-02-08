class PriceList < ActiveRecord::Base
  extend Enumerize

  mount_uploader :file, PriceListUploader

  belongs_to :pharmacy

  scope :ordered, -> { order 'id desc' }

  enumerize :state, in: [:queued, :importing, :done], default: :queued

  validates :file, presence: true

  after_commit :import_file, on: :create

  def start!
    update_attributes! state: :importing, start_at: Time.now
  end

  def finish!
    update_attributes! state: :done, finish_at: Time.now
  end

  def filename
    file.file.filename
  end

  def job
    Hashie::Mash.new Sidekiq::Status::get_all job_id if job_id.present?
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
