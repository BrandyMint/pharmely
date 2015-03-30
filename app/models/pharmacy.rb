require 'securerandom'
class Pharmacy < ActiveRecord::Base
  has_many :drugs
  has_many :price_lists
  has_many :bunches
  belongs_to :company

  mount_uploader :building_photo, PhotoUploader
  mount_uploader :exterior_photo, PhotoUploader
  mount_uploader :interior_photo, PhotoUploader

  scope :ordered, -> { order :address }

  update_index('drugs#drug') { drugs }

  delegate :title, to: :company

  before_create :generate_api_key

  def self.find_by_key key
    where(api_key: key).first!
  end

  def city
    super || company.city
  end

  def to_s
    title
  end

  def drugs_count
    drugs.count
  end

  def location
    [lng, lat]
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex 5
  end

end
