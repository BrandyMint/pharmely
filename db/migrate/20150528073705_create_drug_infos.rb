class CreateDrugInfos < ActiveRecord::Migration
  def change
    create_table :drug_infos do |t|
      t.text :title
      t.text :producer
      t.text :source
      t.text :item_url
      t.text :picture_url
      t.text :html_data, null: false
      t.text :eans, array: true, default: [], null: false

      t.timestamps null: false
    end
    add_index :drug_infos, :eans, using: :gin
  end
end
