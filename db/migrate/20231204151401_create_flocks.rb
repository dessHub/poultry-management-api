class CreateFlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :flocks do |t|
      t.string :title
      t.datetime :date_of_birth
      t.string :breed
      t.integer :quantity
      t.text :notes

      t.timestamps
    end
  end
end
