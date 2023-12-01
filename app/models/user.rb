class User < ApplicationRecord
    has_many :farm_users
    has_many :farms, :through => :farm_users

    has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true, uniqueness: true
    validates :password_confirmation, presence: true

    enum role: [:super_admin, :farm_user]

    before_save :generate_role

    

    def generate_role
        if role?
            self.role = 'farm_user'
        end
    end

    def is_farm_admin?(farm)
        farm_user = self.farm_users.find_by(farm: farm)
        return false if farm_user.nil?
        return farm_user.role == 'admin'
    end
end
