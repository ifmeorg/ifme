class CreatePasswordHistories < ActiveRecord::Migration[5.2]
  def up
    create_table :password_histories do |t|
      t.integer :user_id, null: false
      t.string :encrypted_password
      t.datetime :created_at, null: false
    end

    # Populate initial value from users table
    execute <<-SQL
      INSERT INTO password_histories(user_id, encrypted_password, created_at)
        SELECT id, encrypted_password, updated_at
        FROM users
    SQL
  end

  # rake db:migrate:down VERSION=20181030143627
  def down
    drop_table(:password_histories)
  end
end
