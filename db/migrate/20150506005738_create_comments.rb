# encoding: UTF-8
class CreateComments < ActiveRecord::Migration

  create_table :comments, force: true do |t|
    t.references :user, index: true, null: false
    t.string   :comment_type
    t.integer  :commented_on
    t.text     :comment
    t.string   :visibility
    t.text :viewers
    t.timestamps
  end

  add_foreign_key :comments, :users

end