class CreateFarmingMethods < ActiveRecord::Migration[7.0]
  def change
    create_table :farming_methods do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
