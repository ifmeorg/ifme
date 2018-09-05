class ChangeReporterIdToBeIntegerInReports < ActiveRecord::Migration[5.0]
  def change
    change_column :reports, :reporter_id, :integer, using: "reporter_id::integer"
  end
end
