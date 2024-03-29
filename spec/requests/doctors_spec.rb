require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/doctors/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/doctors/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/doctors/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
