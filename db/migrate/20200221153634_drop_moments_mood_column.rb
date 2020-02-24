class DropMomentsMoodColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :moments, :mood
  end
end
