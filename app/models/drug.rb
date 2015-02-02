class Drug < ActiveRecord::Base
  belongs_to :pharmacy

  update_index('drugs#drug') { self }

  validates :price, presence: true
  validates :name, presence: true
  #validates :producer, presence: true
  #validates :country, presence: true
  validates :stock_quantity, presence: true, numericality: true

  def self.create_from_elastic object
    attr = object.attributes

    pharmacy = Pharmacy.where(name: attr['pharmacy.title']).first || Pharmacy.create!(name: attr['pharmacy.title'], city: attr['pharmacy.city'], address: attr['pharmacy.address'])

    pharmacy.drugs.create! name: attr['name'], price: attr['price'], country: attr['country'], stock_quantity: attr['stock_quantity'], producer: attr['producer']

  end

  def to_s
    name
  end

  def name
    super.to_s.mb_chars.capitalize
  end

  def country
    super.to_s.mb_chars.capitalize
  end

  def producer
    super.to_s.capitalize
  end
end
