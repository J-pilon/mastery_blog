require 'rails_helper'

RSpec.describe "Session", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /new" do
    it "returns http success" do
      get signin_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http status 302" do
      post signin_path, params: {user: {email: user.email, password: user.password}}
      expect(response).to have_http_status(302)
    end
  end

  describe "POST /destroy" do
    it "returns http status 302" do
      post signout_path
      expect(response).to have_http_status(302)
    end
  end
end
