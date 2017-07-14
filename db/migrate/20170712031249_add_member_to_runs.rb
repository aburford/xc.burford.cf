class AddMemberToRuns < ActiveRecord::Migration[5.0]
  def change
    add_reference :runs, :member, foreign_key: true
  end
end
