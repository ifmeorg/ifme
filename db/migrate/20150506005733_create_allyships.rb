# encoding: UTF-8
class CreateAllyships < ActiveRecord::Migration

  create_table :allyships, force: true do |t|
    t.references  :user, index: true, null: false
    t.references  :ally, references: :user, index: true, null: false
    t.integer  :status
    t.timestamps
  end

  add_foreign_key :allyships, :users
  add_foreign_key :allyships, :users, column: :ally_id

end
