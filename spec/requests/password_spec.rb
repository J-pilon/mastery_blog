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
    context 'when params are valid' do
      it "returns http status 302" do
        user_password_params = {email: user.email}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when email is nil' do
      it "returns http status 422" do
        user_password_params = {email: nil}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end

    context 'when email can\'t be found' do
      it "returns http status 422" do
        user_password_params = {email: "*********"}
        post users_password_path, params: user_password_params
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "GET users/password/edit" do
    it "returns http status 200" do
      get edit_users_password_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT users/password" do
    context 'when params are valid' do
      it "returns http status 302" do
        user_password_params = {user: {password: "new password"}}
        put users_password_path(user), params: user_password_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when params are invalid' do
      it "returns http status 422" do
        user_password_params = {user: {password: nil}}
        put users_password_path(user), params: user_password_params
        expect(response).to have_http_status(422)
      end
    end
  end
end
