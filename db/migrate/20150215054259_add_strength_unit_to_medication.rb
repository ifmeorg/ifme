class AddStrengthUnitToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :strength_unit, :string
  end
end
