class NullableInDrugs < ActiveRecord::Migration
  def up
    change_column :drugs, :producer, :string, null: true
    change_column :drugs, :country, :string, null: true
    #change_column :drugs, :price, :decimal, precision: 12, scale: 2, null: true

    add_column    :drugs, :article, :string
    add_column    :drugs, :barcodes, :string
    add_column    :drugs, :unit, :string
  end

  def down
    remove_column :drugs, :article
    remove_column :drugs, :unit
    remove_column :drugs, :barcodes
  end
end
