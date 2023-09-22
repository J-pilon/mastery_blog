class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil if session[:user_id]
    redirect_to signin_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
