# encoding: UTF-8
class CreateStrategies < ActiveRecord::Migration

  create_table :strategies, force: true do |t|
    t.references :user, index: true, null: false
    t.text     :category
    t.text     :description
    t.text     :viewers
    t.boolean  :comment
    t.string   :name
    t.timestamps
  end

  add_foreign_key :strategies, :users

end
