class AddWorkTimeToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :work_time, :string
  end
end
