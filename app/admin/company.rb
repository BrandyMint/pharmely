ActiveAdmin.register Company do
  menu label: 'Аптечные компании'

  decorate_with CompanyDecorator

  index do
    column :logo
    column :city
    column :title
    column :telephones
    column :pharmacies do |c|
      link_to c.pharmacies.count, admin_pharmacies_url(q: { company_id_eq: c.id })
    end
    actions
  end

  form :html => { :multipart => true } do |f|
    f.inputs do
      f.input :city
      f.input :title
      f.input :telephones
      f.input :logo, :as => :file
    end
    f.inputs "Доступ" do
      f.input :login
      f.input :password
    end
    f.actions
  end

  permit_params Company.attribute_names

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
