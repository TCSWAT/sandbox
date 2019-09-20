class ApplicationController < ActionController::Base

  include Swagger::Docs::ImpotentMethods
  protect_from_forgery with: :null_session

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def authenticate_user_api_key!
    if request.env["HTTP_X_API_KEY"].present?
      user, error_msg, code = User.from_api_key(request.env["HTTP_X_API_KEY"])
      if user.present?
        @current_user ||= user
        current_use ||= @current_user
      else
        render json: { error: true, message: error_msg }, status: code
      end
    else
      render json: { error: true, message: "API key required" }, status: 401
    end
  end
end
