class ApplicationController < ActionController::Base

  include Swagger::Docs::ImpotentMethods
  protect_from_forgery with: :null_session

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

end
