class AddUserIdIndexToPasswordHistories < ActiveRecord::Migration[6.0]
  def change
    add_index :password_histories, [:encrypted_password, :user_id], unique: true
    add_foreign_key :password_histories, :users
  end
end
