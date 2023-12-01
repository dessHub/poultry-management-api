class CreateFarmUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :farm_users do |t|
      t.references :farm, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role, comment: "admin, manager"

      t.timestamps
    end
  end
end
