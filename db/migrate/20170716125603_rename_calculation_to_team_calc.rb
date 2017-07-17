class RenameCalculationToTeamCalc < ActiveRecord::Migration[5.0]
  def change
  	rename_table :calculations, :team_calcs
  end
end
