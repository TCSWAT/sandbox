class UsersController < ApplicationController


  def welcome
    @user = current_user
  end

  def show
  end

  def address
  end
end
