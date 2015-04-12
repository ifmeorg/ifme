class ViewPermissionToAllies < ActiveRecord::Migration
  def change
	add_column :users, :view_permission, :boolean, :default => false
  end
end
