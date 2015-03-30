class AddNewWorktimeToPharmacies < ActiveRecord::Migration
  def change
    add_column :pharmacies, :week_day_works_from, :time
    add_column :pharmacies, :week_day_works_till, :time
    add_column :pharmacies, :weekend_works_from, :time
    add_column :pharmacies, :weekend_works_till, :time
    add_column :pharmacies, :around_the_clock, :boolean, default: :false
  end
end
