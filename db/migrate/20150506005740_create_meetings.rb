# encoding: UTF-8
class CreateMeetings < ActiveRecord::Migration

  create_table :meetings, force: true do |t|
    t.string   :name
    t.text     :description
    t.text     :location
    t.string   :time
    t.integer  :maxmembers
    t.references :group, index: true, null: false
    t.string   :date
    t.timestamps
  end

  add_foreign_key :meetings, :groups

end
