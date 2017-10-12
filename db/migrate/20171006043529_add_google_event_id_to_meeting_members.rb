class AddGoogleEventIdToMeetingMembers2017 < ActiveRecord::Migration[5.0]
  def change
    add_column :meeting_members, :google_event_id, :string
  end
end
