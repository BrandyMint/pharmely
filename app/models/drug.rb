class Drug < ActiveRecord::Base
  belongs_to :pharmacy

  update_index('drugs#drug') { self }

  def self.create_from_elastic object
    attr = object.attributes

    pharmacy = Pharmacy.where(name: attr['pharmacy.title']).first || Pharmacy.create!(name: attr['pharmacy.title'], city: attr['pharmacy.city'], address: attr['pharmacy.address'])

    pharmacy.drugs.create! name: attr['name'], price: attr['price'], country: attr['country'], stock_quantity: attr['stock_quantity'], producer: attr['producer']

  end
end