class RegistrationsController < ApplicationController

  before_action :profile, only: :create

  def new
    @user = User.new
    @profile = Profile.new
  end

  def create
    @user = User.new(user_params)
    @user.profile = @profile

    if @user.valid? && @profile.valid?
      @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def profile
    @profile = Profile.new(profile_params)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name)
  end
end
