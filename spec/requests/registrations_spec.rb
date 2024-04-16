require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  describe 'GET /signup' do
    it 'responds with status 200' do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /signup' do
    context 'when params are valid' do
      it 'responds with status 302' do
        user_params = FactoryBot.attributes_for(:user)
        profile_params = FactoryBot.attributes_for(:profile)
        post signup_path, params: { user: user_params, profile: profile_params }
        expect(response).to have_http_status(302)
      end
    end

    context 'when params are invalid' do
      it 'responds with status 422' do
        user_params = FactoryBot.attributes_for(:user, email: nil)
        profile_params = FactoryBot.attributes_for(:profile)
        post signup_path, params: { user: user_params, profile: profile_params }
        expect(response).to have_http_status(422)
      end
    end
  end
end
