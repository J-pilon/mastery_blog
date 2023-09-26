module ApplicationHelper
  def profile_image_url(profile)
    return profile.image_url if profile && profile.image_url
    image_path("blank-profile-picture.webp")
  end
end
