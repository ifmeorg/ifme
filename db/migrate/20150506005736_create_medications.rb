# encoding: UTF-8
class CreateMedications < ActiveRecord::Migration

  create_table :medications, force: true do |t|
    t.references :user, index: true, null: false
    t.string   :name
    t.integer  :dosage
    t.string   :refill
    t.integer  :total
    t.integer  :strength
    t.string   :strength_unit
    t.string   :dosage_unit
    t.string   :total_unit
    t.text     :comments
    t.timestamps
  end

  add_foreign_key :medications, :users


end
