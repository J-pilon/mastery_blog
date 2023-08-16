class RegistrationsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = profile.build_user(registration_params)

    if @user.valid?
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

  def registration_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
