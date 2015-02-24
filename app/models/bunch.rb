class Bunch < ActiveRecord::Base
  belongs_to :pharmacy

  has_many :bunch_files

  validates :max, presence: true
  validates :key, presence: true
end
