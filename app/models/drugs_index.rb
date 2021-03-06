
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
      field :working_in_weekends
      field :around_the_clock

      field :week_day_from, type: 'long', value: ->(o) {
        o.week_day_works_from.strftime("%H%M").to_i if o.week_day_works_from
      }
      field :week_day_till, type: 'long', value: ->(o) {
        o.week_day_works_till.strftime("%H%M").to_i if o.week_day_works_till
      }
      field :weekend_from, type: 'long', value: ->(o) {
        o.weekend_works_from.strftime("%H%M").to_i if o.weekend_works_from
      }
      field :weekend_till, type: 'long', value: ->(o) {
        o.weekend_works_till.strftime("%H%M").to_i if o.weekend_works_till
      }
    end
  end
end

