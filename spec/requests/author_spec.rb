require 'rails_helper'

RSpec.describe "Authors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/author/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/author/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/author/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/author/update"
      expect(response).to have_http_status(:success)
    end
  end

end
