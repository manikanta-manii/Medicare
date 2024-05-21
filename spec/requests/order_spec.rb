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

  describe "PATCH /update" do    
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    let(:address_p) {FactoryBot.create(:address,patient: patient)}
    let(:order) {FactoryBot.create(:order,patient: patient,ordered: false,total_price:0)}
    let(:medicine) {FactoryBot.create(:medicine)}
    let(:order_item) {FactoryBot.create(:order_item,order: order,medicine: medicine,quantity: 2, price:medicine.price)}
    
    before(:each) do
      sign_in user_p
    end 
    
    it "successfull updation with old address and no prescription" do 
      patch order_path(
         id: order.id,
         old: address_p.id
       )
       expect(response.body).to eq("ok")
    end

    it "successfull updation with new address and no prescription" do 
      patch order_path(
         id: order.id,
         new: {
           country:"new_country",
           state:"new_state",
           city:"new_city",
           street:"new_street"
         }
       )
       expect(response.body).to eq("ok")
    end

    
  end
end