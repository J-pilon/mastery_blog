require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /signup" do
    it "responds with status 200" do
      get signup_path
      expect(response).to have_http_status(200)
    end
  end
end
