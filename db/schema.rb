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

ActiveRecord::Schema.define(version: 20160727141506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advisees", force: :cascade do |t|
    t.string   "first_name",          null: false
    t.string   "last_name",           null: false
    t.string   "email",               null: false
    t.string   "graduation_semester", null: false
    t.string   "graduation_year",     null: false
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "photo"
  end

  add_index "advisees", ["user_id"], name: "index_advisees_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",        null: false
    t.integer  "semester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graduation_plans", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "advisee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string   "uid",           null: false
    t.string   "provider",      null: false
    t.string   "refresh_token"
    t.string   "access_token"
    t.datetime "expires_at"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "identities", ["uid"], name: "index_identities_on_uid", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.string   "description"
    t.datetime "start_time",  null: false
    t.datetime "end_time",    null: false
    t.integer  "advisee_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id",     null: false
  end

  add_index "meetings", ["advisee_id"], name: "index_meetings_on_advisee_id", using: :btree
  add_index "meetings", ["user_id"], name: "index_meetings_on_user_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.text     "body",          null: false
    t.integer  "noteable_id"
    t.string   "noteable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "notes", ["noteable_type", "noteable_id"], name: "index_notes_on_noteable_type_and_noteable_id", using: :btree

  create_table "semesters", force: :cascade do |t|
    t.string   "semester",                           null: false
    t.integer  "year",                               null: false
    t.boolean  "remaining_courses",  default: false, null: false
    t.integer  "graduation_plan_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
