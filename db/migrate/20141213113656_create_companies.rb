class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :title, null: false
      t.string :logo
      t.string :telephones
      t.string :city, null: false, default: 'Чебоксары'

      t.timestamps null: false
    end

    remove_column :pharmacies, :logo

    add_column :pharmacies, :company_id, :integer

    Pharmacy.find_each do |p|
      p.create_company! title: p.title
      p.save!
    end

    change_column :pharmacies, :company_id, :integer, null: false
    remove_column :pharmacies, :name
    remove_column :pharmacies, :city

    add_index :pharmacies, :company_id
  end
end
