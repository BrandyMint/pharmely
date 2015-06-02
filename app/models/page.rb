class Page < ActiveRecord::Base

  validates :title, presence: true
  validates :path, presence: true, uniqueness: true

end
