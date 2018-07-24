class RenameUseridOnMeetingMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column(:meeting_members, :userid, :user_id)
  end
end
