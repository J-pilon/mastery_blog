class PasswordController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user&.generate_reset_token && send_password_reset_email
      redirect_to email_sent_users_password_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find_by(email: params[:email], reset_token: params[:reset_token])
    if !@user&.is_reset_token_valid?
      render :new, status: :unprocessable_entity, message: "Invalid Token: please try again"
    end
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user&.update(password: params[:user][:password])
      redirect_to signin_path
    elsif 
      render :edit, status: :unprocessable_entity
    end
  end

  def email_sent
    @user = User.new
  end

  private

  def password_params
    params.require(:user).permit(:password)
  end

  def send_password_reset_email
    edit_users_password_link = edit_users_password_path(email: @user.email, reset_token: @user.reset_token)
    send_email(user: @user, contents: password_reset_email_contents, link: edit_users_password_link)
  end

  def password_reset_email_contents
    { 
      subject: 'Reset Password Instructions',
      html_body: '<h1>Hello <first_name></h1>\n
                <p>Someone has requested a link to change your password. You can do this through the link below.\n
                <a href>change my password</a>\n
                If you didn\'t request this, please ignore this email.\n
                Your password won\'t change until you access the link above and create a new one.</p>',
      encoding: 'UTF-8'
    }
  end
end