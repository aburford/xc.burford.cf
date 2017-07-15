class CreateCalculations < ActiveRecord::Migration[5.0]
  def change
    create_table :calculations do |t|
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
