class Flock < ApplicationRecord
    belongs_to :farm, class_name: "Farm", foreign_key: :farm_id
    belongs_to :chicken_type, class_name: "ChickenType", foreign_key: :chicken_type_id
    belongs_to :farming_method, class_name: "FarmingMethod", foreign_key: :farming_method_id
    has_many :growths
    has_many :mortalities
end
