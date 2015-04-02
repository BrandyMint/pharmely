class AddWorkingInWeekendsToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :working_in_weekends, :bool
  end
end
