class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.decimal :distance
      t.integer :duration
      t.string :title
      t.text :note
      t.date :date

      t.timestamps
    end
  end
end
