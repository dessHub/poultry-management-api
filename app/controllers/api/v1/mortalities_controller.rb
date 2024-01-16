class Api::V1::MortalitiesController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index
        mortalities = Mortality.where(flock_id: params[:flock_id])
        render json: mortalities, include: {flock: {}}
    end

    def show
        mortality = Mortality.find(params[:id])
        render json: mortality, include: {flock: {}}
    end

    def create
        flock = Flock.find(params[:flock_id])
        farm = flock.farm
        mortality = Mortality.new(mortality_params)
        mortality.flock_id = params[:flock_id]

        if @current_user.is_farm_user?(farm)
            if mortality.save
                render json: mortality
            else
                render json: { error: mortality.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to create mortality for this flock'}, status: :unprocessable_entity
        end
    end

    def update
        mortality = Mortality.find(params[:id])
        flock = mortality.flock
        if @current_user.role === 'super_admin' || @current_user.is_farm_user?(flock.farm)
            if mortality.update(mortality_params)
                render json: mortality
            else
                render json: {error_msg: mortality.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this mortality details'}, status: :unprocessable_entity
        end
    end

    def destroy
        mortality = Mortality.find(params[:id])
        flock = mortality.flock

        if @current_user.role === 'super-admin' || @current_user.is_farm_user?(flock.farm)
            if mortality.destroy
                render json: {success_msg: "Successfully deleted"}
            else
                render json: {error_msg: "Unable to deleted"}
            end
        else
            render json: {error_msg: 'Unauthorised to delete'}, status: :unprocessable_entity
        end
    end

    private

    def mortality_params
        params.permit(:age, :cause_of_death, :quantity, :notes)
    end
end
