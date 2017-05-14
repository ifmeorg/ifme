class AddSlugToMoments < ActiveRecord::Migration
  def change
    add_column :moments, :slug, :string
    add_index :moments, :slug, unique: true
  end
end
