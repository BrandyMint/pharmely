class Company < ActiveRecord::Base
  has_many :pharmacies
  has_many :drugs, through: :pharmacies

  mount_uploader :logo, LogoUploader

  scope :ordered, -> { order :name }
end
