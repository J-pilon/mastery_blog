require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:user_params) { {user: {email: "test@test.com", password: "password", password_confirmation: "password"}} } 
    it "returns http status 302" do
      post signup_path, params: user_params
      expect(response).to have_http_status(302)
    end
  end

end
