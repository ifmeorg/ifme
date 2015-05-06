class RenameSessionMembersToMeetingMembers < ActiveRecord::Migration
  def change
  	rename_table :meeting_members, :meeting_members
  end
end
