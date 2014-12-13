class AddLogoToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :logo, :string
  end
end
