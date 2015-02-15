class ChangeTypeForMedication < ActiveRecord::Migration
  def change
    change_table :medications do |t|
      t.change :dosage, 'integer USING CAST(dosage AS integer)'
      t.change :total, 'integer USING CAST(total AS integer)'
      t.change :strength, 'integer USING CAST(strength AS integer)'
    end
  end
end
