class BunchFile < ActiveRecord::Base
  belongs_to :bunch

  mount_uploader :file, PriceListUploader

  scope :ordered, -> { order 'id asc' }

  after_commit :queue_import, on: :create, if: :complete?

  delegate :complete?, :queue_import, to: :bunch

  def file_size
    file.size
  end

end
