class CreateGrowths < ActiveRecord::Migration[7.0]
  def change
    create_table :growths do |t|
      t.integer :age
      t.integer :weight, comment: "Weight in grams"
      t.text :notes
      t.references :flock, foreign_key: true

      t.timestamps
    end
  end
end
