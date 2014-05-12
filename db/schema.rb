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

ActiveRecord::Schema.define(version: 20140512001607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: true do |t|
    t.integer  "userid"
    t.integer  "trigger"
    t.integer  "medication"
    t.string   "message"
    t.string   "means"
    t.string   "days"
    t.string   "time_hour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "time_minute"
    t.string   "time_period"
  end

  create_table "allies", force: true do |t|
    t.integer  "userid"
    t.string   "allies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "comments", force: true do |t|
    t.string   "comment_type"
    t.integer  "commented_on"
    t.integer  "comment_by"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medications", force: true do |t|
    t.string   "name"
    t.string   "dosage"
    t.string   "refill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "moods", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "supports", force: true do |t|
    t.integer  "userid"
    t.string   "support_type"
    t.string   "support_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "triggers", force: true do |t|
    t.string   "category"
    t.string   "name"
    t.string   "mood"
    t.string   "why"
    t.string   "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.string   "viewers"
  end

  create_table "users", force: true do |t|
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
    t.string   "firstname"
    t.string   "lastname"
    t.string   "location"
    t.string   "timezone"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
