class ChangeReporteeIdToBeIntegerInReports < ActiveRecord::Migration[5.0]
  def change
    change_column :reports, :reportee_id, :integer, using: "reportee_id::integer"
  end
end
