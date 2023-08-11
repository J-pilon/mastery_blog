class ApplicationController < ActionController::Base
  def current_profile
    @profile ||= User.profile
  end
end
