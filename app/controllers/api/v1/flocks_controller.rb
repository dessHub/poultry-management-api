class Api::V1::FlocksController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index 
        flocks = Flock.all
        render json: flocks, include: {farm: {}, chicken_type: {}, farming_method: {}}
    end

    def show
        flock = Flock.find(params[:id])
        render json: flock, include: {farm: {}, chicken_type: {}, farming_method: {}}
    end

    def create
        farm = Farm.find(flock_params[:farm_id])
        flock = Flock.new(flock_params)

        if @current_user.is_farm_user?(farm)
            if flock.save
                render json: flock
            else
                render json: { error: flock.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to create flock for this farm'}, status: :unprocessable_entity
        end
    end

    def update
        flock = Flock.find(params[:id])
        if @current_user.role === 'super_admin' || @current_user.is_farm_user?(flock.farm)
            if flock.update(flock_params)
                render json: flock
            else
                render json: {error_msg: flock.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this flock details'}, status: :unprocessable_entity
        end
    end

    def destroy
        flock = Flock.find(params[:id])

        if @current_user.role === 'super-admin' || @current_user.is_farm_user?(flock.farm)
            if flock.destroy
                render json: {success_msg: "flock successfully deleted"}
            else
                render json: {error_msg: "Unable to deleted the flock"}
            end
        else
            render json: {error_msg: 'Unauthorised to delete this flock'}, status: :unprocessable_entity
        end
    end

    private

    def flock_params
        params.permit(:title, :date_of_birth, :breed, :quantity, :notes, :farm_id, :chicken_type_id, :farming_method_id)
    end
end
