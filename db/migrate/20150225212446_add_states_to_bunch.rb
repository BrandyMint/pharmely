class AddStatesToBunch < ActiveRecord::Migration
  def change
    change_table "bunches" do |t|
      t.string   "state",        default: "loading", null: false
      t.integer  "drugs_count"
      t.integer  "errors_count"
      t.text     "results"
      t.string   "job_id"
      t.datetime "start_at"
      t.datetime "finish_at"
    end
  end
end
