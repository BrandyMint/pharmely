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

class AddPhotoFieldsToPharmacies < ActiveRecord::Migration

  def up
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"

    create_table "active_admin_comments", force: :cascade do |t|
      t.string   "namespace"
      t.text     "body"
      t.string   "resource_id",   null: false
      t.string   "resource_type", null: false
      t.integer  "author_id"
      t.string   "author_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

    create_table "admin_users", force: :cascade do |t|
      t.string   "email",                  default: "", null: false
      t.string   "encrypted_password",     default: "", null: false
      t.string   "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer  "sign_in_count",          default: 0,  null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
    add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

    create_table "bunch_files", force: :cascade do |t|
      t.integer  "bunch_id"
      t.string   "file",       null: false
      t.integer  "number",     null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    add_index "bunch_files", ["bunch_id", "number"], name: "index_bunch_files_on_bunch_id_and_number", unique: true, using: :btree
    add_index "bunch_files", ["bunch_id"], name: "index_bunch_files_on_bunch_id", using: :btree

    create_table "bunches", force: :cascade do |t|
      t.integer  "pharmacy_id"
      t.string   "key",                               null: false
      t.string   "type"
      t.integer  "max",                               null: false
      t.datetime "created_at",                        null: false
      t.datetime "updated_at",                        null: false
      t.string   "state",         default: "loading", null: false
      t.integer  "drugs_count"
      t.integer  "errors_count"
      t.text     "results"
      t.string   "job_id"
      t.datetime "start_at"
      t.datetime "finish_at"
      t.text     "error_message"
    end

    add_index "bunches", ["pharmacy_id", "key"], name: "index_bunches_on_pharmacy_id_and_key", unique: true, using: :btree
    add_index "bunches", ["pharmacy_id"], name: "index_bunches_on_pharmacy_id", using: :btree

    create_table "companies", force: :cascade do |t|
      t.string   "title",                            null: false
      t.string   "logo"
      t.string   "telephones"
      t.string   "city",       default: "Чебоксары", null: false
      t.datetime "created_at",                       null: false
      t.datetime "updated_at",                       null: false
      t.string   "login"
      t.string   "password"
    end

    create_table "drugs", force: :cascade do |t|
      t.string   "name",                                    null: false
      t.string   "producer"
      t.string   "country"
      t.decimal  "price",          precision: 12, scale: 2
      t.integer  "stock_quantity",                          null: false
      t.integer  "pharmacy_id",                             null: false
      t.datetime "created_at",                              null: false
      t.datetime "updated_at",                              null: false
      t.string   "article"
      t.string   "barcodes"
      t.string   "unit"
    end

    add_index "drugs", ["pharmacy_id"], name: "index_drugs_on_pharmacy_id", using: :btree

    create_table "pharmacies", force: :cascade do |t|
      t.string   "address",        null: false
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
      t.string   "telephones"
      t.decimal  "lng"
      t.decimal  "lat"
      t.integer  "company_id",     null: false
      t.string   "work_time"
      t.string   "api_key"
      t.string   "building_photo"
      t.string   "exterior_photo"
      t.string   "interior_photo"
    end

    add_index "pharmacies", ["company_id"], name: "index_pharmacies_on_company_id", using: :btree

    create_table "price_lists", force: :cascade do |t|
      t.integer  "pharmacy_id"
      t.string   "file",                             null: false
      t.string   "state",        default: "loading", null: false
      t.integer  "drugs_count"
      t.integer  "errors_count"
      t.text     "results"
      t.datetime "created_at",                       null: false
      t.datetime "updated_at",                       null: false
      t.string   "job_id"
      t.datetime "start_at"
      t.datetime "finish_at"
    end

    add_index "price_lists", ["pharmacy_id"], name: "index_price_lists_on_pharmacy_id", using: :btree

    create_table "sessions", force: :cascade do |t|
      t.string   "session_id", null: false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
    add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

    add_foreign_key "bunch_files", "bunches"
    add_foreign_key "bunches", "pharmacies"
    add_foreign_key "drugs", "pharmacies"
    add_foreign_key "price_lists", "pharmacies"
  end
end
