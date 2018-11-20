class ChangeRefillColumnType < ActiveRecord::Migration[5.2]
  def up
    change_column(:medications, :refill, 'timestamptz USING CAST(refill AS timestamptz)')
  end

  def down
    change_column(:medications, :refill, :string)
  end
end
