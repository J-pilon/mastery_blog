class PasswordController < ApplicationController
  before_action :find_user_by_email, only: [:create, :update]

  def new
    @user = User.new
  end

  def create
    if @user && @user.generate_reset_token && aws_email_service.send_email!
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

  def find_user_by_email
    @user = User.find_by(email: params[:user][:email])
  end

  def password_params
    params.require(:user).permit(:password)
  end

  def aws_email_service
    edit_users_password_link = edit_users_password_path(reset_token: @user.reset_token)

    EmailService.new(client: aws_ses_client, 
                      users: @user, 
                      type: "password_reset_email",
                      link: edit_users_password_link)
  end

  def aws_ses_client
    Aws::SES::Client.new
  end
end