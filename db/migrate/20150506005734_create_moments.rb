# encoding: UTF-8
class CreateMoments < ActiveRecord::Migration

 create_table :moments, force: true do |t|
    t.references :user, index: true, null: false
   t.text     :category
    t.string   :name
    t.string   :mood
    t.text     :why
    t.text     :fix
   t.text     :viewers
    t.boolean  :comment
    t.text     :strategies
    t.timestamps
 end

 add_foreign_key :moments, :users

end
