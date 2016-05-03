# encoding: UTF-8
class SetupDatabase < ActiveRecord::Migration
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allies", force: true do |t|
    t.integer  "userid1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userid2"
    t.integer  "status"
  end

  create_table "bootsy_image_galleries", force: true do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: true do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "date"
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

  create_table "moments", force: true do |t|
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
    t.text     "conditions"
    t.string   "token"
    t.string   "uid"
    t.string   "provider"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
