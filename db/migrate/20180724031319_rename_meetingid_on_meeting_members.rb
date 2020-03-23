class RenameMeetingidOnMeetingMembers < ActiveRecord::Migration[5.0]
  def change
    rename_column(:meeting_members, :meetingid, :meeting_id)
  end
end
