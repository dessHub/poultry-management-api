class Farm < ApplicationRecord
    attr_accessor :current_user

    has_many :farm_users
    has_many :users, :through => :farm_users
    has_many :flocks

    after_save :create_farm_user

    private

    def create_farm_user
        farm_user = self.farm_users.build(user: current_user, farm: self, role: 'admin')
        farm_user.save
    end
end
