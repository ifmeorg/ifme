class AddSecretSharesToMoments < ActiveRecord::Migration[4.2]
  def change
    add_column :moments, :secret_share_identifier, :uuid
    add_column :moments, :secret_share_expires_at, :datetime
    add_index :moments, :secret_share_identifier, unique: true
  end
end
