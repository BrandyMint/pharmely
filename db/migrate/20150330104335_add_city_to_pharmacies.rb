class AddCityToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :city, :string
  end
end
