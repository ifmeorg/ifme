class AddAccessExpiresAtToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :access_expires_at, :datetime
  end
end
