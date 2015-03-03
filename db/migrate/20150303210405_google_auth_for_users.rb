class GoogleAuthForUsers < ActiveRecord::Migration
  def change
  	add_column :users, :token, :string
  	add_column :users, :uid, :string
  	add_column :users, :provider, :string
  end
end
