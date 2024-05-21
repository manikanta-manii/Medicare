require 'rails_helper'

RSpec.describe "OrderItems", type: :request do
  describe "GET /index" do
    let!(:user_p) {FactoryBot.create(:user, role: 2)}
    let!(:patient) {FactoryBot.create(:patient, user: user_p)}
    let!(:medicine) {FactoryBot.create(:medicine)}
    let!(:order) {FactoryBot.create(:order,patient: patient,ordered: false,total_price:0)}
    let!(:order_item) {FactoryBot.create(:order_item,order: order,medicine: medicine,quantity: 2, price:medicine.price)}
    # let(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor)}

    before(:each) do
      sign_in user_p
    end

    it "is a successful request" do 
      get order_items_path
      expect(response).to have_http_status(:success)
    end
  end

  

  describe "POST /create" do
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    let(:medicine) {FactoryBot.create(:medicine)}

    before(:each) do
      sign_in patient.user
    end 
    
    it "render same page if order_item is added" do
      # debugger
      post order_items_path(
        {
        medicine_id: medicine.id,
        price: medicine.price,
      })
      expect(response).to redirect_to(medicines_path)
    end

    it "render root path if order_item is not added" do
      # debugger
      #invalid medicine id
      post order_items_path(
        {
        medicine_id: 0,
        price: medicine.price,
      })
      expect(response).to redirect_to(root_path)
    end

  end

  describe "PATCH /update" do    
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    let(:medicine) {FactoryBot.create(:medicine)}
    let(:order) {FactoryBot.create(:order,patient: patient,ordered: false,total_price:0)}
    let(:order_item) {FactoryBot.create(:order_item,order: order,medicine: medicine,quantity: 2, price:medicine.price)}

    before(:each) do
      sign_in patient.user
    end 
    
    it "successfull updation increment order quantity" do 
      patch order_item_path(
        order_item,
        {
        quantity:"increment"
      })
      # debugger
      expect(response).to have_http_status(:success)
      expect(OrderItem.find_by(id: order_item.id).quantity).to eq(3)
    end

    it "successfull updation decrement order quantity" do 
      patch order_item_path(
        order_item,
        {
        quantity:"decrement"
      })
      # debugger
      expect(response).to have_http_status(:success)
      expect(OrderItem.find_by(id: order_item.id).quantity).to eq(1)
    end

  end

  describe "DELETE /destroy" do
    let(:user_p) {FactoryBot.create(:user, role: 2)}
    let(:patient) {FactoryBot.create(:patient, user: user_p)}
    let(:medicine1) {FactoryBot.create(:medicine)}
    let(:medicine2) {FactoryBot.create(:medicine)}
    let(:order) {FactoryBot.create(:order,patient: patient,ordered: false,total_price:0)}
    let(:order_item1) {FactoryBot.create(:order_item,order: order,medicine: medicine1,quantity: 2, price:medicine1.price)}
    let(:order_item2) {FactoryBot.create(:order_item,order: order,medicine: medicine2,quantity: 2, price:medicine2.price)}

    before(:each) do
      sign_in patient.user
    end 
     
    it "remove the order item" do 
      #order = [] , order_item1 = val , order_item2 = val , order =  [ order_item1 ,order_item2]
      # expect(Order.find_by(id:order_item1.order_id).order_items.count).to eq(2)
      delete order_item_path(order_item1)
      expect(Order.find_by(id:order_item2.order_id).order_items.count).to eq(1)
    end
   
   end

end
