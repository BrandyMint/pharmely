class AddTelephonesToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :telephones, :string
  end
end
