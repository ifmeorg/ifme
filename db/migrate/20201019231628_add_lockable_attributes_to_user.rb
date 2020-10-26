class AddLockableAttributesToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :failed_attempts, :integer, default: 0, null: false
    add_column :users, :locked_at, :datetime
  end
end
