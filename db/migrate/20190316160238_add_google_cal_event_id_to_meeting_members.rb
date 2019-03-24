class AddGoogleCalEventIdToMeetingMembers < ActiveRecord::Migration[5.2]
  def up
    add_column(:meeting_members, :google_cal_event_id, :string)
  end

  def down
    remove_column(:meeting_members, :google_cal_event_id)
  end
end
