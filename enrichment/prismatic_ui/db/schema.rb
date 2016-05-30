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

ActiveRecord::Schema.define(version: 20160530055643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "object_id"
    t.string   "object_class"
    t.string   "action_class"
    t.string   "action_type"
    t.string   "app_id"
    t.string   "app_name"
    t.string   "user_id"
    t.string   "session_id"
    t.string   "tracker_name"
    t.text     "page_url"
    t.text     "page_path"
    t.string   "page_referrer"
    t.text     "page_search"
    t.string   "user_agent"
    t.string   "ip"
    t.string   "country_code"
    t.string   "country_name"
    t.string   "region_code"
    t.string   "region_name"
    t.string   "city"
    t.string   "time_zone"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "zip_code"
    t.string   "platform"
    t.string   "device"
    t.string   "browser"
    t.string   "screen_width"
    t.string   "screen_height"
    t.string   "os_name"
    t.datetime "event_time"
    t.datetime "collector_event_time"
    t.json     "properties"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
