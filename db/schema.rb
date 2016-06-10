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

ActiveRecord::Schema.define(version: 20160512174202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allyships", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "ally_id",    null: false
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "allyships", ["ally_id"], name: "index_allyships_on_ally_id", using: :btree
  add_index "allyships", ["user_id"], name: "index_allyships_on_user_id", using: :btree

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
    t.integer  "user_id",     null: false
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "comment_type"
    t.integer  "commented_on"
    t.text     "comment"
    t.string   "visibility"
    t.text     "viewers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id",   null: false
    t.integer  "user_id"
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree
  add_index "group_members", ["user_id"], name: "index_group_members_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medications", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "name"
    t.integer  "dosage"
    t.string   "refill"
    t.integer  "total"
    t.integer  "strength"
    t.string   "strength_unit"
    t.string   "dosage_unit"
    t.string   "total_unit"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medications", ["user_id"], name: "index_medications_on_user_id", using: :btree

  create_table "meeting_members", force: :cascade do |t|
    t.integer  "meeting_id", null: false
    t.integer  "user_id",    null: false
    t.boolean  "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meeting_members", ["meeting_id"], name: "index_meeting_members_on_meeting_id", using: :btree
  add_index "meeting_members", ["user_id"], name: "index_meeting_members_on_user_id", using: :btree

  create_table "meetings", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "location"
    t.string   "time"
    t.integer  "maxmembers"
    t.integer  "group_id",    null: false
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meetings", ["group_id"], name: "index_meetings_on_group_id", using: :btree

  create_table "moments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "category"
    t.string   "name"
    t.text     "mood"
    t.text     "why"
    t.text     "fix"
    t.text     "viewers"
    t.boolean  "comment"
    t.text     "strategies"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moments", ["user_id"], name: "index_moments_on_user_id", using: :btree

  create_table "moods", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "moods", ["user_id"], name: "index_moods_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "uniqueid"
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "strategies", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.text     "category"
    t.text     "description"
    t.text     "viewers"
    t.boolean  "comment"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "strategies", ["user_id"], name: "index_strategies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                              null: false
    t.string   "encrypted_password",                 null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "location"
    t.string   "timezone"
    t.text     "about"
    t.string   "avatar"
    t.text     "conditions"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
    t.boolean  "users"
    t.boolean  "comment_notify"
    t.boolean  "boolean"
    t.boolean  "ally_notify"
    t.boolean  "group_notify"
    t.boolean  "meeting_notify"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["encrypted_password"], name: "index_users_on_encrypted_password", using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "allyships", "users"
  add_foreign_key "allyships", "users", column: "ally_id"
  add_foreign_key "categories", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "medications", "users"
  add_foreign_key "meeting_members", "meetings"
  add_foreign_key "meeting_members", "users"
  add_foreign_key "meetings", "groups"
  add_foreign_key "moments", "users"
  add_foreign_key "moods", "users"
  add_foreign_key "strategies", "users"
end
