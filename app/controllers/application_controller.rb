class ApplicationController < ActionController::Base

  def current_profile
    @profile ||= User.first.profile
  end
end
