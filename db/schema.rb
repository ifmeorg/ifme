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

ActiveRecord::Schema.define(version: 2018_11_19_152925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allyships", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "ally_id"
    t.integer "status"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer "bootsy_resource_id"
    t.string "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string "image_file"
    t.integer "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.integer "comment_by"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "visibility"
    t.text "viewers"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "group_members", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description"
    t.string "slug"
    t.index ["slug"], name: "index_groups_on_slug", unique: true
  end

  create_table "medications", force: :cascade do |t|
    t.string "name"
    t.integer "dosage"
    t.datetime "refill"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "total"
    t.integer "strength"
    t.string "strength_unit"
    t.string "dosage_unit"
    t.string "total_unit"
    t.text "comments"
    t.string "slug"
    t.boolean "add_to_google_cal", default: false
    t.integer "weekly_dosage", default: [0, 1, 2, 3, 4, 5, 6], array: true
    t.index ["slug"], name: "index_medications_on_slug", unique: true
  end

  create_table "meeting_members", force: :cascade do |t|
    t.integer "meeting_id"
    t.integer "user_id"
    t.boolean "leader"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "location"
    t.string "time"
    t.integer "maxmembers"
    t.integer "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "date"
    t.string "slug"
    t.index ["slug"], name: "index_meetings_on_slug", unique: true
  end

  create_table "moments", force: :cascade do |t|
    t.text "category"
    t.string "name"
    t.text "mood"
    t.text "why"
    t.text "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.text "viewers"
    t.boolean "comment"
    t.text "strategy"
    t.string "slug"
    t.uuid "secret_share_identifier"
    t.datetime "secret_share_expires_at"
    t.datetime "published_at"
    t.index ["secret_share_identifier"], name: "index_moments_on_secret_share_identifier", unique: true
    t.index ["slug"], name: "index_moments_on_slug", unique: true
  end

  create_table "moods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "slug"
    t.index ["slug"], name: "index_moods_on_slug", unique: true
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "uniqueid"
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perform_strategy_reminders", id: :serial, force: :cascade do |t|
    t.integer "strategy_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refill_reminders", id: :serial, force: :cascade do |t|
    t.integer "medication_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "reporter_id"
    t.integer "reportee_id"
    t.text "reasons"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_id"
  end

  create_table "strategies", force: :cascade do |t|
    t.integer "user_id"
    t.text "category"
    t.text "description"
    t.text "viewers"
    t.boolean "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "slug"
    t.datetime "published_at"
    t.index ["slug"], name: "index_strategies_on_slug", unique: true
  end

  create_table "supports", force: :cascade do |t|
    t.integer "user_id"
    t.string "support_type"
    t.text "support_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "take_medication_reminders", id: :serial, force: :cascade do |t|
    t.integer "medication_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "location"
    t.string "timezone"
    t.text "about"
    t.string "avatar"
    t.text "conditions"
    t.string "token"
    t.string "uid"
    t.string "provider"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "comment_notify"
    t.boolean "ally_notify"
    t.boolean "group_notify"
    t.boolean "meeting_notify"
    t.string "locale"
    t.datetime "access_expires_at"
    t.string "refresh_token"
    t.boolean "banned", default: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

end
