class Api::V1::UsersController < ::Api::BaseController
    before_action :authenticate_request, only: [:show, :update, :destory]

    def index 
        @users = User.all
        render json: @users
    end

    def show
        @user = User.find(params[:id])
        render json: @user
    end

    def create
        user = User.new(user_params)
        if user.save
          token = encode_token({ user_id: user.id })
          render json: { token: token }
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            render json: @user
        else
            render json: {error_msg: @user.errors}, status: :unprocessable_entity
        end
    end

    def destroy
      @user = User.find(params[:id])

      if @user.destroy
        render json: {success_msg: "User successfully deleted"}
      else
        render json: {error_msg: "Unable to deleted the User"}
      end
    end

    private

    def user_params
        params.permit(:name, :phone, :role, :email, :password)
    end

    def encode_token(user_id)
      JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base)
    end
    
end
