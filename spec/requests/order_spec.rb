require 'rails_helper'

RSpec.describe "Orders", type: :request do
  describe "GET /index" do
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    # let(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor)}

    before(:each) do
      sign_in patient.user
    end

    it "is a successful request" do 
      get orders_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    let(:address_p) {FactoryBot.create(:address,patient: patient)}
    let(:order) {FactoryBot.create(:order,patient: patient,address_id: address_p.id,ordered: true)}

    before(:each) do
      sign_in(patient.user)
    end

    it "is successful request" do
      get order_path(order)
      expect(response).to have_http_status(:success)
    end
  end
  
end