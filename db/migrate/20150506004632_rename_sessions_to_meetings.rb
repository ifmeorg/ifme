class RenameSessionsToMeetings < ActiveRecord::Migration
  def change
  	rename_table :sessions, :meetings
  end
end
