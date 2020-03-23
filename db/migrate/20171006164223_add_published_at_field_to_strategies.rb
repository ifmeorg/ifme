class AddPublishedAtFieldToStrategies < ActiveRecord::Migration[5.0]
  def change
    add_column :strategies, :published_at, :datetime
  end
end
