class CreateMomentStrategiesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :moments_strategies do |t|
      t.integer :moment_id
      t.integer :strategy_id
    end

    add_index :moments_strategies, [:moment_id, :strategy_id], unique: true
    add_foreign_key :moments_strategies, :moments
    add_foreign_key :moments_strategies, :strategies
  end
end
