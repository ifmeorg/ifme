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

ActiveRecord::Schema.define(version: 20161125015132) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allyships", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ally_id"
    t.integer  "status"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "comment_type"
    t.integer  "commented_on"
    t.integer  "comment_by"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "visibility"
    t.text     "viewers"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer  "groupid"
    t.integer  "userid"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "medications", force: :cascade do |t|
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

  create_table "meeting_members", force: :cascade do |t|
    t.integer  "meetingid"
    t.integer  "userid"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "location"
    t.string   "time"
    t.integer  "maxmembers"
    t.integer  "groupid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "date"
  end

  create_table "moments", force: :cascade do |t|
    t.text     "category"
    t.string   "name"
    t.text     "mood"
    t.text     "why"
    t.text     "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
    t.text     "viewers"
    t.boolean  "comment"
    t.text     "strategies"
  end

  create_table "moods", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "userid"
    t.string   "uniqueid"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refill_reminders", force: :cascade do |t|
    t.integer  "medication_id", null: false
    t.boolean  "active",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "strategy_id"
  end

  create_table "self_care_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "self_care_strategy_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "selfcare_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategies", force: :cascade do |t|
    t.integer  "userid"
    t.text     "category"
    t.text     "description"
    t.text     "viewers"
    t.boolean  "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "self_care_strategy"
  end

  create_table "strategy_email_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "strategy_migrations", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategy_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "supports", force: :cascade do |t|
    t.integer  "userid"
    t.string   "support_type"
    t.text     "support_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "take_medication_reminders", force: :cascade do |t|
    t.integer  "medication_id", null: false
    t.boolean  "active",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "location"
    t.string   "timezone"
    t.text     "about"
    t.string   "avatar"
    t.text     "conditions"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.boolean  "comment_notify"
    t.boolean  "ally_notify"
    t.boolean  "group_notify"
    t.boolean  "meeting_notify"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  create_table "weekly_strategy_reminders", force: :cascade do |t|
    t.integer  "strategy_id", null: false
    t.boolean  "active",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
