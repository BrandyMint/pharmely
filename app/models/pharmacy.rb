class Pharmacy < ActiveRecord::Base
  has_many :drugs
  belongs_to :company

  scope :ordered, -> { order :address }

  update_index('drugs#drug') { drugs }

  delegate :title, :city, to: :company

  def to_s
    title
  end

  def drugs_count
    drugs.count
  end

  def location
    [lng, lat]
  end
end
