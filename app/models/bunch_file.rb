class BunchFile < ActiveRecord::Base
  belongs_to :bunch

  mount_uploader :file, PriceListUploader

end
