class RenameGroupidOnGroupMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column(:group_members, :groupid, :group_id)
  end
end
