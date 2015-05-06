class RenameSessionidToMeetingid < ActiveRecord::Migration
  def change
  	rename_column :meeting_members, :meetingid, :meetingid
  end
end
