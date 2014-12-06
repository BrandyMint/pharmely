# Старыи индекс-источник

class PharmacyIndex < Chewy::Index
  define_type :drugs do
    field :name
    field :producer
    field :country
    field :price
    field :stock_quantity
    field :pharmacy, type: 'object' do
      field :title
      field :address
      field :city
    end
  end
end
