class AddUseridToMoods < ActiveRecord::Migration
  def change
    add_column :moods, :userid, :integer
  end
end
