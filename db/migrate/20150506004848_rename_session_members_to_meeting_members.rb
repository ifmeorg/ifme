class RenameSessionMembersToMeetingMembers < ActiveRecord::Migration
  def change
  	rename_table :session_members, :meeting_members
  end
end
