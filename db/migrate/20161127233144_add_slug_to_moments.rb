class AddSlugToMoments < ActiveRecord::Migration[4.2]
  def change
    add_column :moments, :slug, :string
    add_index :moments, :slug, unique: true
  end
end
