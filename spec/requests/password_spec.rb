require 'rails_helper'

RSpec.describe "Password", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET users/password/new" do
    it "returns http status 200" do
      get new_users_password_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST users/password" do
    let(:email_service_stub) { allow_any_instance_of(EmailService).to receive(:send!).and_return(true) }

    context 'when params are valid' do
      it "returns http status 302" do
        email_service_stub
        user_password_params = {user: {email: user.email}}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when email is nil' do
      it "returns http status 422" do
        email_service_stub
        user_password_params = {user: {email: nil}}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end

    context 'when email can\'t be found' do
      it "returns http status 422" do
        email_service_stub
        user_password_params = {user: {email: "*********"}}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET users/password/edit" do
    context 'when params are valid' do
      it "returns http status 200" do
        user.generate_reset_token
        get edit_users_password_path, params: {email: user.email, reset_token: user.reset_token}
        expect(response).to have_http_status(200)
      end
    end

    context 'when params are invalid' do
      it "returns http status 422" do
        user.generate_reset_token
        get edit_users_password_path, params: {email: user.email, reset_token: "wrong token"}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT users/password" do
    context 'when params are valid' do
      it "returns http status 302" do
        user.generate_reset_token
        user_password_params = {email: user.email, user: {password: "new password", password_confirmation: "new password"}}
        put users_password_path, params: user_password_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when password is invalid' do
      it "returns http status 422" do
        user.generate_reset_token
        user_password_params = {email: user.email, user: {password: nil, password_confirmation: nil}}
        put users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end

    context 'when email is invalid' do
      it "returns http status 422" do
        user.generate_reset_token
        user_password_params = {email: "wrong email", user: {password: "new password", password_confirmation: "new password"}}
        put users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end
  end
end
