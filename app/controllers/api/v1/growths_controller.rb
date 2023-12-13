class Api::V1::GrowthsController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index
        logger.info ">>>> #{params[:flock_id]}"
        growths = Growth.where(flock_id: params[:flock_id])
        render json: growths, include: {flock: {}}
    end

    def show
        growth = Growth.find(params[:id])
        render json: growth, include: {flock: {}}
    end

    def create
        flock = Flock.find(params[:flock_id])
        farm = flock.farm
        growth = Growth.new(growth_params)
        growth.flock_id = params[:flock_id]

        if @current_user.is_farm_user?(farm)
            if growth.save
                render json: growth
            else
                render json: { error: growth.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to create growth for this flock'}, status: :unprocessable_entity
        end
    end

    def update
        growth = Growth.find(params[:id])
        flock = growth.flock
        if @current_user.role === 'super_admin' || @current_user.is_farm_user?(flock.farm)
            if growth.update(growth_params)
                render json: growth
            else
                render json: {error_msg: growth.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this growth details'}, status: :unprocessable_entity
        end
    end

    def destroy
        growth = Growth.find(params[:id])
        flock = growth.flock

        if @current_user.role === 'super-admin' || @current_user.is_farm_user?(flock.farm)
            if growth.destroy
                render json: {success_msg: "Successfully deleted"}
            else
                render json: {error_msg: "Unable to deleted"}
            end
        else
            render json: {error_msg: 'Unauthorised to delete'}, status: :unprocessable_entity
        end
    end

    private

    def growth_params
        params.permit(:age, :weight, :notes)
    end
end
