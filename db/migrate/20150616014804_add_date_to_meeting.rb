class AddDateToMeeting < ActiveRecord::Migration
  def change
  	add_column :meetings, :date, :string
  end
end
