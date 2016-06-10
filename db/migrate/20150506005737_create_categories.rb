# encoding: UTF-8
class CreateCategories < ActiveRecord::Migration

  create_table :categories, force: true do |t|
    t.references :user, index: true, null: false
    t.string   :name
    t.text     :description
    t.timestamps
  end

  add_foreign_key :categories, :users

end
