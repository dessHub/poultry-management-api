class Api::V1::FarmingMethodsController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index 
        farming_methods = FarmingMethod.all
        render json: farming_methods
    end

    def show
        farming_method = FarmingMethod.find(params[:id])
        render json: farming_method
    end

    def create
        farming_method = FarmingMethod.new(farming_method_params)

        if farming_method.save
          render json: farming_method
        else
          render json: { error: farming_method.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        farming_method = FarmingMethod.find(params[:id])

        if farming_method.update(farming_method_params)
            render json: farming_method
        else
            render json: { error: farming_method.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        farming_method = FarmingMethod.find(params[:id])

        if farming_method.destroy
            render json: {success_msg: "farm method successfully deleted"}
        else
            render json: {error_msg: "Issue deleting the record"}
        end
    end

    private

    def farming_method_params
        params.permit(:title, :description)
    end
end
