# encoding: UTF-8
class CreateUsers < ActiveRecord::Migration
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table :users, force: true do |t|
    t.string   :email,  index: true, unique: true, null: false
    t.string   :encrypted_password, index: true, unique: true, null: false
    t.string   :reset_password_token, inex: true, unique: true
    t.datetime :reset_password_sent_at
    t.datetime :remember_created_at
    t.integer  :sign_in_count,          default: 0,  null: false
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    t.string   :name
    t.string   :location
    t.string   :timezone
    t.text     :about
    t.string   :avatar
    t.text     :conditions
    t.string   :token
    t.string   :uid, index: true, unique: true # Uniqueness can't be guaranteed here
    t.string   :provider
    t.boolean :users, :comment_notify, :boolean
    t.boolean :users, :ally_notify, :boolean
    t.boolean :users, :group_notify, :boolean
    t.boolean :users, :meeting_notify, :boolean
    t.timestamps
  end
end
