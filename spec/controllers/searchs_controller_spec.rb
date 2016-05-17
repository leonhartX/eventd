require 'rails_helper'

RSpec.describe SearchsController, :type => :controller do
  describe "Get index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "search" do
    it "returns http success" do
      post :create, params: { query: "event" }
      expect(response).to have_http_status(:found)
    end
  end
end
