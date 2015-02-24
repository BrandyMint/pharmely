class CreateBunches < ActiveRecord::Migration
  def change
    create_table :bunches do |t|
      t.references :pharmacy, index: true
      t.string :key, null: false
      t.string :type
      t.integer :max, null: false

      t.timestamps null: false
    end
    add_foreign_key :bunches, :pharmacies
    add_index :bunches, [:pharmacy_id, :key], unique: true
  end
end
