class Company < ActiveRecord::Base
  has_many :pharmacies
  has_many :drugs, through: :pharmacies

  mount_uploader :logo, LogoUploader

  scope :ordered, -> { order :title }

  validates :login, uniqueness: true, allow_blank: true

  def authenticate _login, _password
    login==_login && password==_password
  end

  def to_s
    title
  end

  def pharmacies_count
    pharmacies.count
  end

  def drugs_count
    drugs.count
  end
end
