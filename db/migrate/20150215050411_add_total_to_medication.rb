class AddTotalToMedication < ActiveRecord::Migration
  def change
    add_column :medications, :total, :string
  end
end
