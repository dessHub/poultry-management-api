class FarmUser < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    belongs_to :farm, class_name: "Farm", foreign_key: "farm_id"

    enum role: [:admin, :manager]
end
