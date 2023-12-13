class Api::V1::ChickenTypesController < ::Api::BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]

    def index 
        chicken_types = ChickenType.all
        render json: chicken_types
    end

    def show
        chicken_type = ChickenType.find(params[:id])
        render json: chicken_type
    end

    def create
        chicken_type = ChickenType.new(chicken_type_params)

        if chicken_type.save
          render json: chicken_type
        else
          render json: { error: chicken_type.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        chicken_type = ChickenType.find(params[:id])

        if chicken_type.update(chicken_type_params)
            render json: chicken_type
        else
            render json: { error: chicken_type.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        chicken_type = ChickenType.find(params[:id])

        if chicken_type.destroy
            render json: {success_msg: "Chicken type successfully deleted"}
        else
            render json: {error_msg: "Issue deleting the record"}
        end
    end

    private

    def chicken_type_params
        params.permit(:title, :description)
    end
end
