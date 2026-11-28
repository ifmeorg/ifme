# frozen_string_literal: true

class AddPausedAtToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :paused_at, :datetime
  end
end
