class AddStartAtToPriceLists < ActiveRecord::Migration
  def change
    add_column :price_lists, :start_at, :timestamp
    add_column :price_lists, :finish_at, :timestamp
  end
end
