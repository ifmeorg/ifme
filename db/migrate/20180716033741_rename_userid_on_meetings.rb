class RenameUseridOnMeetings < ActiveRecord::Migration[5.0]
  def change
    rename_column(:meetings, :groupid, :group_id)
  end
end
