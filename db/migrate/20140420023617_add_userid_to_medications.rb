class AddUseridToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :userid, :integer
  end
end
