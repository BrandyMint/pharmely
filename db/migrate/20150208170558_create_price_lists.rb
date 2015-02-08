class CreatePriceLists < ActiveRecord::Migration
  def change
    create_table :price_lists do |t|
      t.references :pharmacy, index: true
      t.string :file, null: false
      t.string :state, null: false, default: 'loading'
      t.integer :drugs_count
      t.integer :errors_count
      t.text :results

      t.timestamps null: false
    end
    add_foreign_key :price_lists, :pharmacies
  end
end
