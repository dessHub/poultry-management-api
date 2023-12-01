class CreateFarms < ActiveRecord::Migration[7.0]
  def change
    create_table :farms do |t|
      t.string :name
      t.string :description
      t.string :country
      t.string :location

      t.timestamps
    end
  end
end
