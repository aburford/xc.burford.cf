class ChangeDistanceTypeForRun < ActiveRecord::Migration[5.0]
  def up
    change_column :runs, :distance, :float
  end

  def down
    change_column :runs, :distance, :decimal
  end
end
