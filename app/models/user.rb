class User < ApplicationRecord
    has_many :farms, class_name: "Farm", foreign_key: "user_id"

    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true, uniqueness: true

    before_save :generate_role

    def generate_role
        if role?
            self.role = 'farm-admin'
        end
    end
end
