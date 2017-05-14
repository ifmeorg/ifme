class CreateMedicationReminders < ActiveRecord::Migration
  def change
    create_table :take_medication_reminders do |t|
      t.integer :medication_id, null: false
      t.boolean :active, null:false

      t.timestamps
    end

    create_table :refill_reminders do |t|
      t.integer :medication_id, null: false
      t.boolean :active, null:false

      t.timestamps
    end
  end
end
