class BunchFile < ActiveRecord::Base
  belongs_to :bunch

  mount_uploader :file, PriceListUploader

  #after_commit :queue_import, on: :create, if: :complete?

  delegate :complete?, to: :bunch

  def file_size
    file.size
  end

end
