require "rails_helper"

RSpec.describe ApplicationController, :type => :controller do
  describe "GET #welcome" do
    it "responds successfully with an HTTP 200 status code" do
      get :welcome
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the welcome template" do
      get :welcome
      expect(response).to render_template("welcome")
    end
  end
end