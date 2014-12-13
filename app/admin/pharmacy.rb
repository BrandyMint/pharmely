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
    actions

  end

  permit_params Pharmacy.attribute_names

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
