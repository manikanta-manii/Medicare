require 'rails_helper'

RSpec.describe "Medicines", type: :request do

  describe "GET /index" do
    let(:user) { FactoryBot.create(:user,role: "patient") }

    before(:each) do
      sign_in user
    end

    it "is successful request" do 
      get medicines_path
      expect(response).to have_http_status(:success)
    end

    it "render medicines/index page" do 
      get medicines_path
      expect(response).to render_template("medicines/index")
    end

  end

  describe "POST /create" do
    let(:user) { FactoryBot.build(:user)}
    let(:medicine) { FactoryBot.create(:medicine) }
    before(:each) do
      sign_in user
    end 
    
    it "render medicines/each_medicine on success" do
      post medicines_path(
        {
        name: medicine.name,
        description: medicine.description,
        dosage: medicine.dosage,
        price: medicine.price,
        quantity: medicine.quantity,
        
      })
      expect(response).to render_template("medicines/_each_medicine")
    end

    it "render shared/errors on failure" do
      post medicines_path(
        {
        name: medicine.name,
        description: medicine.description,
        dosage: medicine.dosage,
        price: -1,
        quantity: medicine.quantity,
        
      })
      expect(response).to render_template("shared/_errors")

    end
  end

  describe "PATCH /update" do
    let(:user) { FactoryBot.build(:user)}
    let(:medicine) { FactoryBot.create(:medicine) }
    before(:each) do
      sign_in user
    end 
    
    it "render admin/manage_medicines/each_medicine on success" do
      patch medicine_path(
        medicine,
        {
        name: "dolo 650",
        description: medicine.description,
        dosage: medicine.dosage,
        price: medicine.price,
        quantity: medicine.quantity,
        
      })
      expect(response).to render_template("admin/manage_medicines/_each_medicine")
    end

    it "render shared/errors on failure" do
      patch medicine_path(
        medicine,
        {
        name: medicine.name,
        description: medicine.description,
        dosage: medicine.dosage,
        price: -1,
        quantity: medicine.quantity,
        
      })
      expect(response).to render_template("shared/_errors")
      
    end
  end

  describe "DELETE /destroy" do
    let(:user) { FactoryBot.build(:user)}
    let!(:medicine) { FactoryBot.create(:medicine) }
    before(:each) do
      sign_in user
    end 
    
    it "medicine deletion on success" do
      delete medicine_path(
        medicine
        )
        expect(response).to have_http_status(200)
        expect(response.body).to eq("medicine deleted")
    end

    it "does not destroy the medicine if deletion fails" do
      allow_any_instance_of(Medicine).to receive(:destroy).and_return(false)
      expect {
        delete medicine_path(medicine)
      }.to_not change(Medicine, :count)

      expect(response).to have_http_status(200)
      expect(response.body).to eq("medicine deletion failed")
    end
  end

end

