class ChangeRefillColumnType < ActiveRecord::Migration[5.2]
  def up
    change_column(:medications, :refill, 'timestamp USING CAST(refill AS timestamp)')
  end

  def down
    change_column(:medications, :refill, :string)
  end
end
