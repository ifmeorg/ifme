# frozen_string_literal: true
class AddFileDataToUsersDataRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :users_data_requests, :file_data, :binary
  end
end
