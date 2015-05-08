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

ActiveRecord::Schema.define(version: 20150507231620) do

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
    t.integer  "userid1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid2"
    t.integer  "status"
  end

  create_table "ally_permissions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "view",       default: true
    t.boolean  "comment",    default: true
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "comments", force: true do |t|
    t.string   "comment_type"
    t.integer  "commented_on"
    t.integer  "comment_by"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "visibility"
  end

  create_table "group_members", force: true do |t|
    t.integer  "groupid"
    t.integer  "userid"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "medications", force: true do |t|
    t.string   "name"
    t.integer  "dosage"
    t.string   "refill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.integer  "total"
    t.integer  "strength"
    t.string   "strength_unit"
    t.string   "dosage_unit"
    t.string   "total_unit"
    t.text     "comments"
  end

  create_table "meeting_members", force: true do |t|
    t.integer  "meetingid"
    t.integer  "userid"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "location"
    t.string   "time"
    t.integer  "maxmembers"
    t.integer  "groupid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moods", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "strategies", force: true do |t|
    t.integer  "userid"
    t.text     "category"
    t.text     "description"
    t.text     "viewers"
    t.boolean  "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "supports", force: true do |t|
    t.integer  "userid"
    t.string   "support_type"
    t.text     "support_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "triggers", force: true do |t|
    t.text     "category"
    t.string   "name"
    t.string   "mood"
    t.text     "why"
    t.text     "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.text     "viewers"
    t.boolean  "comment"
    t.text     "strategies"
    t.integer  "post_type"
    t.text     "view_permissions"
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
    t.string   "name"
    t.string   "location"
    t.string   "timezone"
    t.text     "about"
    t.string   "avatar"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
