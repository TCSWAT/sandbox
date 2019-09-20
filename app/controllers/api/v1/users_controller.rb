class Api::V1::UsersController < ApplicationController

  skip_before_action :authenticate_user!
  before_action :authenticate_user_api_key!, only: [:profile]


  swagger_controller :users, "User Management"

  swagger_api :create do
    summary 'Create the user'
    notes 'Create the user'
    param :form, :"user[email]", :string, :required, 'User Email'
    param :form, :"user[first_name]", :string, :required, 'User FirstName'
    param :form, :"user[last_name]", :string, :required, 'User LastName'
    param :form, :"user[password]", :string, :required, 'User Password'
    param :form, :"user[password_confirmation]", :string, :required, 'User Passwore Confirmation'
    response :bad_request
    response :forbidden
    response :unauthorized
    response :created
  end
  def create
    @user = User.new(user_params)
    if @user.save
      render 'profile', status: :created
    else
      render json: { error: @user.errors }, status: :bad_request
    end
  end

  swagger_api :profile do
    summary 'Fetches the user profile'
    notes 'Gets the user profile'
    response :bad_request
    response :forbidden
    response :unauthorized
    response :ok
  end
  def profile
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end