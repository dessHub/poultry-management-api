class User < ApplicationRecord
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
