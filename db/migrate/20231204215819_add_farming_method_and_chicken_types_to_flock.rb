class AddFarmingMethodAndChickenTypesToFlock < ActiveRecord::Migration[7.0]
  def change
    add_reference :flocks, :farming_method, foreign_key: true
    add_reference :flocks, :chicken_type, foreign_key: true
  end

  def drop
    remove_reference :flocks, :farming_method, foreign_key: true, index: false
    remove_reference :flocks, :chicken_type, foreign_key: true, index: false
  end
end
