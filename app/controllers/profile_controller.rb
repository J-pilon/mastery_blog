class ProfileController < ApplicationController
  before_action :profile

  def show; end

  def edit; end

  def update
    user = @profile.user
    if @profile.update(profile_params) && user.update(user_params)
      redirect_to profile_path(id: @profile)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :image_url, :bio)
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
