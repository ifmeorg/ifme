class CreateUsersDataRequests < ActiveRecord::Migration[6.0]
  def up
    unless table_exists? :users_data_requests
      create_table :users_data_requests do |t|
        t.string :request_id, null: false
        t.integer :status_id, null: false
        t.references :user, foreign_key: true, null: false
        t.timestamps
      end
      add_index :users_data_requests, :request_id, unique: true unless index_exists?(:users_data_requests, :request_id)
      add_index :users_data_requests, :user_id unless index_exists?(:users_data_requests, :user_id)
      execute "CREATE UNIQUE INDEX IF NOT EXISTS index_users_data_requests_on_users_id_and_status_uniq
         ON users_data_requests(user_id, status_id) WHERE (status_id = #{Users::DataRequest::STATUS[:enqueued]})"
    end
  end

  def down
    execute "DROP INDEX IF EXISTS index_users_data_requests_on_users_id_and_status_uniq"
    remove_index  :users_data_requests, :request_id if index_exists?(:users_data_requests, :request_id)
    remove_index  :users_data_requests, :user_id if index_exists?(:users_data_requests, :user_id)
    drop_table :users_data_requests if table_exists? :users_data_requests
  end
end
