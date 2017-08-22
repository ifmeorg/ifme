class AddLocaleToUsers < ActiveRecord::Migration[4.2]
  def change
  	add_column :users, :locale, :string
  end
end
