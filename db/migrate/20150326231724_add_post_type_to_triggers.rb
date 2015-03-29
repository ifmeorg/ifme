class AddPostTypeToTriggers < ActiveRecord::Migration
  def change
	add_column :triggers, :post_type, :integer
  end
end
