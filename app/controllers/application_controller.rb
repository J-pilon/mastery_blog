class ApplicationController < ActionController::Base
  helper_method :current_user, :current_profile, :logged_in?

  def current_profile
    @profile ||= current_user&.profile
  end

  def current_categories
    @current_categories ||= Category.pluck(:name, :id)
  end

  def authenticate_user!
    redirect_to signin_path unless current_user
  end

  def current_user
    @user ||=
      begin
        return nil unless session[:user_id]

        User.find(session[:user_id])
      end
  end

  def logged_in?
    current_user&.persisted?
  end

  def send_email(contents:, link:, user: @user)
    EmailService.new(user: user, contents: contents, link: link)
  end
end
