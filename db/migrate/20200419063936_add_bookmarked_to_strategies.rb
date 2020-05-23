class AddBookmarkedToStrategies < ActiveRecord::Migration[5.2]
  def change
    add_column :strategies, :bookmarked, :boolean, default: false
  end
end
