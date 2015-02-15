class AddStrengthToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :strength, :string
  end
end
