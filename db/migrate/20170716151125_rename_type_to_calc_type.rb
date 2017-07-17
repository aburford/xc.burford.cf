class RenameTypeToCalcType < ActiveRecord::Migration[5.0]
  def change
  	rename_column :mem_calcs, :type, :calc_type
  end
end
