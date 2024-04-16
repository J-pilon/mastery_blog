module ApplicationHelper
  def profile_image_url(profile)
    return image_path(profile.image_url) if profile && profile.image_url

    image_path('blank-profile-picture.webp')
  end

  def format_date(date)
    date.strftime('%B %-d, %Y')
  end
end
