class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "pharmacies", "companies", name: "pharmacies_company_id_fk"
  end
end
