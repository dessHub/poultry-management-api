class Api::V1::FarmsController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destory]

    def index 
        @farms = Farm.all
        render json: @farms
    end

    def show
        @farm = Farm.find(params[:id])
        render json: @farm
    end

    def create
        farm = Farm.new(farm_params)
        farm.user_id = @current_user.id
        
        if farm.save
          render json: farm
        else
          render json: { error: farm.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @farm = Farm.find(params[:id])
        if @current_user.role === 'super-admin' || @current_user.id === params[:id].to_i
            if @farm.update(farm_params)
                render json: @farm
            else
                render json: {error_msg: @farm.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this farm details'}, status: :unprocessable_entity
        end
    end

    def destroy
        @farm = Farm.find(params[:id])

        if @current_user.role === 'super-admin' || @current_user.id === params[:id].to_i
            if @farm.destroy
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
