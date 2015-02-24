class AddApiKeyToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :api_key, :string
  end
end
