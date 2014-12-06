# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141206083604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drugs", force: true do |t|
    t.string   "name",                                    null: false
    t.string   "producer",                                null: false
    t.string   "country",                                 null: false
    t.decimal  "price",          precision: 12, scale: 2, null: false
    t.integer  "stock_quantity",                          null: false
    t.integer  "pharmacy_id",                             null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "drugs", ["pharmacy_id"], name: "index_drugs_on_pharmacy_id", using: :btree

  create_table "pharmacies", force: true do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.string   "city",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pharmacies", ["name"], name: "index_pharmacies_on_name", unique: true, using: :btree

  add_foreign_key "drugs", "pharmacies"
end
