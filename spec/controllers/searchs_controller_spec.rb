require 'rails_helper'

RSpec.describe SearchsController, :type => :controller do
  describe "search" do
    it "returns http success" do
      post :create, params: { query: "event" }
      expect(response).to have_http_status(:success)
    end
  end
end
