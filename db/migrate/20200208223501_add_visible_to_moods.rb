class AddVisibleToMoods < ActiveRecord::Migration[5.2]
  def change
    add_column :moods, :visible, :boolean, default: true
  end
end
