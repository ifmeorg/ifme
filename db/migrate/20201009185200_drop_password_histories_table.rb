class DropPasswordHistoriesTable < ActiveRecord::Migration[6.0]
  def up
    drop_table(:password_histories)
  end

  # rake db:migrate:down VERSION=20201009185200
  def down
    create_table :password_histories do |t|
      t.integer :user_id, null: false
      t.string :encrypted_password
      t.datetime :created_at, null: false
    end
  end
end
