class AddDaysLateToRuns < ActiveRecord::Migration[5.0]
  def change
    add_column :runs, :days_late, :integer
  end
end
