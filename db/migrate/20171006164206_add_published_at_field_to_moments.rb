class AddPublishedAtFieldToMoments < ActiveRecord::Migration[5.0]
  def change
    add_column :moments, :published_at, :datetime
  end
end
