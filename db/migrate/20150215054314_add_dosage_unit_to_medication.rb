class AddDosageUnitToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :dosage_unit, :string
  end
end
