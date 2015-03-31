ActiveAdmin.register Pharmacy do
  menu label: 'Точки продаж'

  index do
    column :company
    column :telephones
    column :city
    column :address
    column :work_time
    column :location
    column :drugs do |p|
      link_to p.drugs.count, admin_drugs_url(q: { pharmacy_id_eq: p.id })
    end
    actions defaults: true do |pharmacy|
      link_to 'Импорт прайс-листа', edit_pharmacy_url(pharmacy)
    end

  end

  action_item :import, only: [:show, :edit] do 
    link_to 'Импорт прайс-листа', edit_pharmacy_url(pharmacy)
  end

  member_action :import do
    redirect_to edit_pharmacy_url(resource)
  end

  permit_params Pharmacy.attribute_names

  form do |f|
    f.inputs do
      f.input :company
      f.input :city
      f.input :address
      f.input :telephones
      f.input :building_photo
      f.input :exterior_photo
      f.input :interior_photo
      f.input :week_day_works_from, include_blank: false
      f.input :week_day_works_till, include_blank: false
      f.input :weekend_works_from,  include_blank: false
      f.input :weekend_works_till,  include_blank: false
      f.input :around_the_clock
      f.input :description
      f.input :lng
      f.input :lat
      f.input :api_key
    end
  end
end
