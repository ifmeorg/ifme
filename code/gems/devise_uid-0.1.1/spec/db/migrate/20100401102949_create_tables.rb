class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              :null => true, :default => ""
      t.string :encrypted_password, :null => true, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      # uid
      t.string :uid

      t.timestamps
    end
    add_index :users, :uid, :unique => true
  end
end
