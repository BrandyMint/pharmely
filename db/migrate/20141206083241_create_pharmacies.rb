class CreatePharmacies < ActiveRecord::Migration
  def change
    create_table :pharmacies do |t|
      t.string :name,    null: false
      t.string :address, null: false
      t.string :city,    null: false

      t.timestamps null: false
    end

    add_index :pharmacies, :name, unique: true
  end
end
