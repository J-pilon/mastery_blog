class PasswordController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.generate_reset_token && aws_email_service.send_email!
      redirect_to email_sent_users_password_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.is_reset_token_valid?(params[:reset_token])
      render :new, status: :unprocessable_entity, message: "Invalid Token: please try again"
    end
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user && @user.update(password: params[:user][:password])
      redirect_to signin_path
    elsif 
      render :edit, status: :unprocessable_entity
    end
  end

  def email_sent
  end

  private

  def password_params
    params.require(:user).permit(:password)
  end

  def aws_email_service
    edit_users_password_link = edit_users_password_path(email: @user.email, reset_token: @user.reset_token)

    EmailService.new(client: aws_ses_client, 
                      users: @user, 
                      type: "password_reset_email",
                      link: edit_users_password_link)
  end

  def aws_ses_client
    Aws::SES::Client.new
  end
end