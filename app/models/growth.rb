class Growth < ApplicationRecord
    belongs_to :flock, class_name: "Flock", foreign_key: "flock_id"
end
