class CreateMomentTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :moment_templates do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.index :slug, unique: true
      t.references :user, foreign_key: true, null: true

      t.timestamps
    end
  end
end
