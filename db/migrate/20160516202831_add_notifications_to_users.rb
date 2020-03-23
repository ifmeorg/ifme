class AddNotificationsToUsers < ActiveRecord::Migration[4.2]
  def change
  	add_column :users, :comment_notify, :boolean
    add_column :users, :ally_notify, :boolean
    add_column :users, :group_notify, :boolean
    add_column :users, :meeting_notify, :boolean
  end
end
