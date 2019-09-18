class UsersController < ApplicationController


  def welcome
    @user = current_user
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.password = user_params[:password] if user_params[:password].present?
    @user.password_confirmation = user_params[:password_confirmation] if user_params[:password_confirmation].present?

    @user.update_attributes(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
