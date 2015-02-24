class CreateBunchFiles < ActiveRecord::Migration
  def up
    create_table :bunch_files do |t|
      t.references :bunch, index: true
      t.string :file, null: false
      t.integer :number, null: false

      t.timestamps null: false
    end
    add_foreign_key :bunch_files, :bunches

    add_index :bunch_files, [:bunch_id, :number], unique: true

    Pharmacy.find_each do |v|
      v.send :generate_api_key
      v.save!
    end
  end
end
