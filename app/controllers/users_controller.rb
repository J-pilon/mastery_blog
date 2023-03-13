class UsersController < ApplicationController
  before_action :set_user

  def new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
