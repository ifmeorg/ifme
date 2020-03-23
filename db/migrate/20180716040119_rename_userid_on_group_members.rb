class RenameUseridOnGroupMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column(:group_members, :userid, :user_id)
  end
end
