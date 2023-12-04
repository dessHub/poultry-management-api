class CreateChickenTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :chicken_types do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
