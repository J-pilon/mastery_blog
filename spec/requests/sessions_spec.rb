require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /signin" do
    it "responds with a status of 200" do
      get signin_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /sessions" do
    context 'when params are valid' do
      it "responds with a status of 302" do
        user = FactoryBot.create(:user)
        post sessions_path, params: {email: user.email, password: user.password}
        expect(response).to have_http_status(302)
      end
    end

    context 'when params are invalid' do
      it "responds with a status of 422" do
        user = FactoryBot.create(:user)
        post sessions_path, params: {email: "fake", password: user.password}
        expect(response).to have_http_status(422)
      end
    end

    context 'when the user isn\'t registered' do
      it 'responds with a status of 422' do
        post sessions_path, params: {email: "fake@fake.com", password: "fake"}
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'POST /signout' do
    it "responds with a status of 302" do
      post signout_path
      expect(response).to have_http_status(302)
    end
  end
end
