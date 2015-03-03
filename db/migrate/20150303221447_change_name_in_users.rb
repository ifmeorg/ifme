class ChangeNameInUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :lastname
  	rename_column :users, :firstname, :name
  end
end
