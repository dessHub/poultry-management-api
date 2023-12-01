class Api::V1::AuthenticationController < ::Api::BaseController
  def authenticate
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      @token = generate_token(@user.id)
      render json: { token: @token, user: @user }
    else
      render json: { error: 'Invalid credentials'}, status: :unauthorized
    end
  end

  private

  def generate_token(user_id)
    exp = 24.hours.from_now.to_i # Token expires in 24 hours
    payload = { user_id: user_id, exp: exp }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
