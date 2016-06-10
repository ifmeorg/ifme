# encoding: UTF-8
class CreateMoods < ActiveRecord::Migration

  create_table :moods, force: true do |t|
    t.references :user, index: true, null: false
    t.string   :name
    t.text     :description
    t.timestamps
  end

  add_foreign_key :moods, :users

end
