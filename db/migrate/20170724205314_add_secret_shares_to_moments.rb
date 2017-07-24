class AddSecretSharesToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :secret_share_identifier, :string
    add_column :moments, :secret_share_expires_at, :datetime
  end
end
