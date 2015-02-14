class AddAboutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
  end
end
