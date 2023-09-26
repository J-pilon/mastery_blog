class PasswordController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.generate_reset_token
      redirect_to email_sent_users_password_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(params[:email])
  end

  def update
    @user = User.find_by(params[:email])

    if @user.update(password_params)
      redirect_to signin_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def email_sent
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end