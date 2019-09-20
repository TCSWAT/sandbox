class Api::V1::UserSessionsController < Devise::SessionsController

  skip_before_action :authenticate_user!, only: [:login]

  swagger_controller :user_sessions, "User Login Management"

  swagger_api :login do
    summary 'Sign in a user and provide api_key'
    param :form, :'user[email]', :string, :required, 'Email'
    param :form, :'user[password]', :password, :required, 'Password'
    response :created
    response :unauthorized
  end
  # POST /resource/sign_in
  def login
    resource = User.find_by_email(sign_in_params[:email])

    if resource && resource.valid_password?(sign_in_params[:password])
      render json: { api_key: JsonWebToken.encode({ user_id: resource.id }, Time.now + 2.hours) }, status: :created
    else
      render json: { error: true, message: "Invalid Credentials" }, status: 401
    end
  end

  private
  def sign_in_params
    params.require(:user).permit(:email, :password)
  end

end