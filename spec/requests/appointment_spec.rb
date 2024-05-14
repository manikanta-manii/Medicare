require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    it "is a successful request" do 
      get appointments_path
      expect(response).to have_http_status(:success)
      puts response.body # Output the response body for inspection
    end

    # it "renders the appointments/index page" do 
    #   get appointments_path
    #   expect(response).to render_template("appointments/index")
    #   puts response.body # Output the response body for inspection
    # end
  end
end