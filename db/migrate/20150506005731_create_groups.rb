# encoding: UTF-8
class CreateGroups < ActiveRecord::Migration

  create_table :groups, force: true do |t|
    t.string   :name
    t.text     :description
    t.timestamps
  end

end
