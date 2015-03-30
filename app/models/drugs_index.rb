
class DrugsIndex < Chewy::Index
  define_type Drug.includes(:pharmacy) do
    field :id
    field :name
    field :producer
    field :country
    field :price,          type: 'float'
    field :stock_quantity, type: 'integer'
    field :pharmacy_id
    field :pharmacy, type: 'object' do
      field :title
      field :address
      field :city
      field :week_day_works_from
      field :week_day_works_till
      field :weekend_works_from
      field :weekend_works_till
    end
  end
end

