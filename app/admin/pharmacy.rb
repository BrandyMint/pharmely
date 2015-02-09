ActiveAdmin.register Pharmacy do
  menu label: 'Точки продаж'

  index do
    column :company
    column :telephones
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

end
