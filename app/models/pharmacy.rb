class Pharmacy < ActiveRecord::Base
  has_many :drugs

  scope :ordered, -> { order :name }

  update_index('drugs#drug') { drugs }

  def title
    name
  end

  def tel
    '22-32-22'
  end

  def to_s
    name
  end

  def location
    [64, 65]
  end
end
