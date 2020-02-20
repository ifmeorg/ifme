class CreateMomentMoods < ActiveRecord::Migration[5.2]
  def change
    create_table :moment_moods do |t|
      t.references :moment, foreign_key: true, index: true
      t.references :mood, foreign_key: true, index: true
    end
  end
end
