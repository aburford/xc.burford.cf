class CreateMemCalcs < ActiveRecord::Migration[5.0]
  def change
    create_table :mem_calcs do |t|
      t.references :member, foreign_key: true
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
