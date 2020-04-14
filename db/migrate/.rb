class AddTotalNoOfDaysToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :total_no_of_days, :date
  end
end
