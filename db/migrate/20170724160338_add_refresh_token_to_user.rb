class AddRefreshTokenToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :refresh_token, :string
  end
end
