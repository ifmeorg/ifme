class RenameUseridOnNotifications < ActiveRecord::Migration[5.0]
  def change
    rename_column(:notifications, :userid, :user_id)
  end
end
