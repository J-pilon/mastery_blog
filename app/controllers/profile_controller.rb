class ProfileController < ApplicationController
  before_action :profile

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
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
    params.require(:profile).permit(:first_name, :last_name, :image_url)
  end
end
