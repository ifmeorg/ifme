class AddUseridToTriggers < ActiveRecord::Migration
  def change
    add_column :triggers, :userid, :integer
  end
end
