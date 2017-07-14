class CreateRunners < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.integer :grade

      t.timestamps
    end
  end
end
