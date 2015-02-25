class PriceList < ActiveRecord::Base
  include WorkerOwner

  mount_uploader :file, PriceListUploader

  belongs_to :pharmacy

  scope :ordered, -> { order 'id desc' }

  validates :file, presence: true

  after_commit :queue_import, on: :create

  def files
    [file.file]
  end

  def filename
    file.file.filename
  end

  private

  def worker_class
    PriceListWorker
  end

end
