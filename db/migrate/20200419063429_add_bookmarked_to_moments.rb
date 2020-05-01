class AddBookmarkedToMoments < ActiveRecord::Migration[5.2]
  def change
    add_column :moments, :bookmarked, :boolean, default: false
  end
end
