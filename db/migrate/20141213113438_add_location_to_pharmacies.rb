class AddLocationToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :lng, :decimal
    add_column :pharmacies, :lat, :decimal
  end
end
