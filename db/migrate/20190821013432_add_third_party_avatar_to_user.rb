class AddThirdPartyAvatarToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :third_party_avatar, :text
  end
end
