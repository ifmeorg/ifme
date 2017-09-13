class AddAddToGoogleCalToMedication < ActiveRecord::Migration[5.0]
  def change
    add_column :medications, :add_to_google_cal, :boolean, :default => false
  end
end
