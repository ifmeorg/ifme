class MakeAlliesJunctionTable < ActiveRecord::Migration
  def change
  	remove_column :allies, :allies
  	rename_column :allies, :userid, :userid1
  	add_column :allies, :userid2, :integer
  	add_column :allies, :status, :integer
  end
end
