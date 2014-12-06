class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name,     null: false
      t.string :producer, null: false
      t.string :country,  null: false
      t.decimal :price,   null: false, precision: 12, scale: 2
      t.integer :stock_quantity, null: false
      t.references :pharmacy, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :drugs, :pharmacies
  end
end
