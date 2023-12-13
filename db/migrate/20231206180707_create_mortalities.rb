class CreateMortalities < ActiveRecord::Migration[7.0]
  def change
    create_table :mortalities do |t|
      t.integer :age
      t.string :cause_of_death, comment: "disease, fatigue, suffocation, other"
      t.text :notes
      t.integer :quantity
      t.references :flock, foreign_key: true

      t.timestamps
    end
  end
end
