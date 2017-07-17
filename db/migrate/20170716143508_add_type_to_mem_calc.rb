class AddTypeToMemCalc < ActiveRecord::Migration[5.0]
  def change
    add_column :mem_calcs, :type, :integer
  end
end
