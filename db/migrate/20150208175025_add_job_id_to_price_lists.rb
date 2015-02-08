class AddJobIdToPriceLists < ActiveRecord::Migration
  def change
    add_column :price_lists, :job_id, :string
  end
end
