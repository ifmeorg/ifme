# frozen_string_literal: true

class AddPublicSharingToMoments < ActiveRecord::Migration[7.0]
  def change
    add_column :moments, :make_public, :boolean,
               default: false, null: false
    add_column :moments, :public_approved_at, :datetime
  end
end