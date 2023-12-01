class Api::V1::UsersController < ::Api::BaseController
    before_action :authenticate_request, only: [:show, :update, :destroy]

    def index 
        users = User.all
        render json: users, include: {farms: {}}
    end

    def show
        user = User.find(params[:id])
        render json: user, include: {farms: {}}
    end

    def create
        user = User.new(user_params)
        if user.save
          token = encode_token(user.id)
          render json: { token: token, user: user }
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:id])
        if @current_user.role === 'super-admin' || @current_user.id === params[:id].to_i
            if user.update(user_params)
                render json: user
            else
                render json: {error_msg: user.errors}, status: :unprocessable_entity
            end
        else
            render json: {error_msg: 'Unauthorised to update this User details'}, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])

        if @current_user.role === 'super-admin' || @current_user.id === params[:id].to_i
            if user.destroy
                render json: {success_msg: "User successfully deleted"}
            else
                render json: {error_msg: "Unable to deleted the User"}
            end
        else
            render json: {error_msg: 'Unauthorised to delete this User'}, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:name, :phone, :email, :password, :password_confirmation)
    end

    def encode_token(user_id)
        exp = 24.hours.from_now.to_i # Token expires in 24 hours
        payload = { user_id: user_id, exp: exp }
        JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
    
end
