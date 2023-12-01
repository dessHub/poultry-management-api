class Api::V1::FarmsController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index 
        farms = Farm.all
        render json: farms, include: {users: {}}
    end

    def show
        farm = Farm.find(params[:id])
        render json: farm, include: {users: {}}
    end

    def create
        farm = Farm.new(farm_params)
        farm.current_user = @current_user

        if farm.save
          render json: farm
        else
          render json: { error: farm.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        farm = Farm.find(params[:id])
        if @current_user.role === 'super_admin' || @current_user.is_farm_admin?(farm)
            if farm.update(farm_params)
                render json: farm
            else
                render json: {error_msg: farm.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this farm details'}, status: :unprocessable_entity
        end
    end

    def destroy
        farm = Farm.find(params[:id])

        if @current_user.role === 'super-admin' || @current_user.is_farm_admin?(farm)
            if farm.destroy
                render json: {success_msg: "farm successfully deleted"}
            else
                render json: {error_msg: "Unable to deleted the farm"}
            end
        else
            render json: {error_msg: 'Unauthorised to delete this farm'}, status: :unprocessable_entity
        end
    end

    private

    def farm_params
        params.permit(:name, :description, :location, :country)
    end
end
