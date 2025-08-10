# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_25_214533) do
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

  create_table "care_plan_contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "slug"
    t.boolean "visible", default: true
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
    t.datetime "created_at", precision: nil
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
    t.timestamptz "refill"
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
    t.string "google_cal_event_id"
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

  create_table "moment_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "slug"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_moment_templates_on_slug", unique: true
    t.index ["user_id"], name: "index_moment_templates_on_user_id"
  end

  create_table "moments", force: :cascade do |t|
    t.string "name"
    t.text "why"
    t.text "fix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.text "viewers"
    t.boolean "comment"
    t.string "slug"
    t.uuid "secret_share_identifier"
    t.datetime "secret_share_expires_at", precision: nil
    t.datetime "published_at", precision: nil
    t.boolean "bookmarked", default: false
    t.boolean "resource_recommendations", default: true
    t.index ["secret_share_identifier"], name: "index_moments_on_secret_share_identifier", unique: true
    t.index ["slug"], name: "index_moments_on_slug", unique: true
  end

  create_table "moments_categories", force: :cascade do |t|
    t.integer "moment_id"
    t.integer "category_id"
    t.index ["moment_id", "category_id"], name: "index_moments_categories_on_moment_id_and_category_id", unique: true
  end

  create_table "moments_moods", force: :cascade do |t|
    t.integer "moment_id"
    t.integer "mood_id"
    t.index ["moment_id", "mood_id"], name: "index_moments_moods_on_moment_id_and_mood_id", unique: true
  end

  create_table "moments_strategies", force: :cascade do |t|
    t.integer "moment_id"
    t.integer "strategy_id"
    t.index ["moment_id", "strategy_id"], name: "index_moments_strategies_on_moment_id_and_strategy_id", unique: true
  end

  create_table "moods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "slug"
    t.boolean "visible", default: true
    t.index ["slug"], name: "index_moods_on_slug", unique: true
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "uniqueid"
    t.text "data"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "perform_strategy_reminders", id: :serial, force: :cascade do |t|
    t.integer "strategy_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "refill_reminders", id: :serial, force: :cascade do |t|
    t.integer "medication_id", null: false
    t.boolean "active", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "reports", force: :cascade do |t|
    t.integer "reporter_id"
    t.integer "reportee_id"
    t.text "reasons"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "comment_id"
  end

  create_table "strategies", force: :cascade do |t|
    t.integer "user_id"
    t.text "description"
    t.text "viewers"
    t.boolean "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "slug"
    t.datetime "published_at", precision: nil
    t.boolean "visible", default: true
    t.boolean "bookmarked", default: false
    t.index ["slug"], name: "index_strategies_on_slug", unique: true
  end

  create_table "strategies_categories", force: :cascade do |t|
    t.integer "strategy_id"
    t.integer "category_id"
    t.index ["strategy_id", "category_id"], name: "index_strategies_categories_on_strategy_id_and_category_id", unique: true
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
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
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
    t.datetime "invitation_created_at", precision: nil
    t.datetime "invitation_sent_at", precision: nil
    t.datetime "invitation_accepted_at", precision: nil
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.integer "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "comment_notify"
    t.boolean "ally_notify"
    t.boolean "group_notify"
    t.boolean "meeting_notify"
    t.string "locale"
    t.datetime "access_expires_at", precision: nil
    t.string "refresh_token"
    t.boolean "banned", default: false
    t.boolean "admin", default: false
    t.text "third_party_avatar"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.datetime "confirmation_sent_at", precision: nil
    t.string "unconfirmed_email"
    t.string "session_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  create_table "users_data_requests", force: :cascade do |t|
    t.string "request_id", null: false
    t.integer "status_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_id"], name: "index_users_data_requests_on_request_id", unique: true
    t.index ["user_id", "status_id"], name: "index_users_data_requests_on_users_id_and_status_uniq", unique: true, where: "(status_id = 1)"
    t.index ["user_id"], name: "index_users_data_requests_on_user_id"
  end

  add_foreign_key "moment_templates", "users"
  add_foreign_key "moments_categories", "categories"
  add_foreign_key "moments_categories", "moments"
  add_foreign_key "moments_moods", "moments"
  add_foreign_key "moments_moods", "moods"
  add_foreign_key "moments_strategies", "moments"
  add_foreign_key "moments_strategies", "strategies"
  add_foreign_key "strategies_categories", "categories"
  add_foreign_key "strategies_categories", "strategies"
  add_foreign_key "users_data_requests", "users"
end
