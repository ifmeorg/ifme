class AddExportToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:export_request,:boolean,default: false
    add_column :users, :export_available,:boolean,default: false
    add_column :users,:data_requested_on,:date,default: nil
  end
end
