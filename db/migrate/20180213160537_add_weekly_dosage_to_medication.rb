class AddWeeklyDosageToMedication < ActiveRecord::Migration[5.0]
  def change
    add_column :medications, :weekly_dosage, :integer, array: true, default: [0,1,2,3,4,5,6]
  end
end
