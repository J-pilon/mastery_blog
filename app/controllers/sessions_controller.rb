class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if validate_email && validate_password
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

  def validate_password
    unless @user.authenticate(session_params[:password])
      @user = User.new
      @user.errors.add(:password, 'is incorrect')
      return false
    end

    true
  end

  def validate_email
    unless @user
      @user = User.new
      @user.errors.add(:email, 'not found. Please sign up first.')
      return false
    end

    true
  end
end
