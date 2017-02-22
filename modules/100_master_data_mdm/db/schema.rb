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

ActiveRecord::Schema.define(version: 20170216065512) do

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "sys_functions", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.string   "menu_code"
    t.string   "status",      default: "ENABLED"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "sys_menus", force: :cascade do |t|
    t.string   "code",           limit: 30,                      null: false
    t.string   "parent_code",    limit: 30
    t.integer  "sequence"
    t.string   "name",           limit: 50
    t.string   "description"
    t.string   "zone_code"
    t.string   "recursion_code"
    t.string   "controller",     limit: 100
    t.string   "action",         limit: 50
    t.string   "status",                     default: "ENABLED"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  create_table "sys_permissions", force: :cascade do |t|
    t.string   "function_code"
    t.string   "controller"
    t.string   "action"
    t.string   "status",        default: "ENABLED"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "sys_users", force: :cascade do |t|
    t.string   "login_name",         limit: 50,                     null: false
    t.string   "first_name",         limit: 50
    t.string   "last_name",          limit: 50
    t.string   "full_name",          limit: 50
    t.string   "email",              limit: 50
    t.string   "phone",              limit: 50
    t.string   "encrypted_password",                                null: false
    t.string   "locked_flag",        limit: 1,  default: "N"
    t.integer  "locked_time",                   default: 600
    t.datetime "locked_until_at"
    t.datetime "last_login_at"
    t.string   "status",                        default: "ENABLED"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

end
