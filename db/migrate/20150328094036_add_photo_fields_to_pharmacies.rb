class AddPhotoFieldsToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :building_photo, :string
    add_column :pharmacies, :exterior_photo, :string
    add_column :pharmacies, :interior_photo, :string
  end
end
