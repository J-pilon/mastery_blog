require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /profile/:id' do
    it 'returns http success' do
      get profile_path(id: user.profile)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET profile/edit/:id' do
    it 'returns http success' do
      get edit_profile_path(id: user.profile)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT profile/:id' do
    context 'when params are valid' do
      it 'returns http success' do
        profile_params = { profile: { first_name: 'fake', last_name: 'fake' } }
        put profile_path(id: user.profile), params: profile_params
        expect(response).to have_http_status(302)
      end
    end

    context 'when params are invalid' do
      it 'returns http success' do
        profile_params = { profile: { first_name: nil, last_name: nil } }
        put profile_path(id: user.profile), params: profile_params
        expect(response).to have_http_status(422)
      end
    end
  end
end
