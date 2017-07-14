class AddDateToRuns < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :date, :date
  end
end
