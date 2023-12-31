class Api::BaseController < ActionController::API

    private

    def authenticate_request
        header = request.headers['Authorization']
        token = header&.split(' ')&.last

        if token
            begin
                decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)&.first
                logger.info "===decode #{decoded_token['user_id']}"
                @current_user = User.find(decoded_token['user_id'])
            rescue JWT::DecodeError
                render json: { error: 'Invalid token' }, status: :unauthorized
                return
            end
        end

        render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    end
end
