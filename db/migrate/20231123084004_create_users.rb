class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :password_digest 
      t.string :password_confirmation
      t.string :role, comment: "super_admin, farm_user"

      t.timestamps
    end
  end
end
