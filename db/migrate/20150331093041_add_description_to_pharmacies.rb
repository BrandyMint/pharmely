class AddDescriptionToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :description, :string
  end
end
