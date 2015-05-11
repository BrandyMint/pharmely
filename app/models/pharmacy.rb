require 'securerandom'
class Pharmacy < ActiveRecord::Base
  has_many :drugs, dependent: :destroy
  has_many :price_lists, dependent: :destroy
  has_many :bunches, dependent: :destroy
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
    super || (company.present? ? company.city : nil)
  end

  def to_s
    title
  end

  def open?
    return true if around_the_clock?
    if time_filled?
      time = Time.now
      if Time.now.wday <= 5
        (time.hour >= week_day_works_from.hour) && (time.hour < week_day_works_till.hour)
      else
        (time.hour >= weekend_works_from.hour) && (time.hour < weekend_works_till.hour)
      end
    else
      false
    end
  end

  def drugs_count
    drugs.count
  end

  def location
    [lng, lat]
  end

  def one_or_more_photo?
    building_photo.present? || exterior_photo.present? ||
      interior_photo.present?
  end

  private

  def generate_api_key
    self.api_key = SecureRandom.hex 5
  end

  def time_filled?
    week_day_works_from.present? && week_day_works_till.present? &&
      weekend_works_from.present? && weekend_works_till.present?
  end
end
