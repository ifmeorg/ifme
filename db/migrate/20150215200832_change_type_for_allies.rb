class ChangeTypeForAllies < ActiveRecord::Migration
  def change
  	change_table :allies do |t|
      t.change :allies, 'text USING CAST(allies AS text)'
    end
  end
end
