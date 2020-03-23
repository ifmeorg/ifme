class CreateMomentMoodsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :moments_moods do |t|
      t.integer :moment_id
      t.integer :mood_id
    end

    add_index :moments_moods, [:moment_id, :mood_id], unique: true
    add_foreign_key :moments_moods, :moments
    add_foreign_key :moments_moods, :moods
  end
end
