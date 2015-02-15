class AddTotalUnitToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :total_unit, :string
  end
end
