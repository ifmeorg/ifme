class AddNoThirdPartyAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :no_third_party_avatar, :boolean, :default => false
  end
end
