require 'rails_helper'

RSpec.describe "Doctors", type: :request do

  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    it "is successful request" do 
      get doctors_path
      expect(response).to have_http_status(:success)
    end

    it "render doctors/index page" do 
      get doctors_path
      expect(response).to render_template("doctors/index")
    end

  end

  describe "POST /create" do
    let(:user) { FactoryBot.build(:user)}
    let(:specialization) { FactoryBot.create(:specialization) }
    before(:each) do
      sign_in user
    end 
    
    it "render doctors/each_doctor on success" do
      post doctors_path(
        {
        name: user.name,
        email: user.email,
        phone_number: "6765456765",
        years_of_experiance: "2",
        consultation_fee: "1000",
        specialization_id: specialization.id
      })
      expect(response).to render_template("doctors/_each_doctor")
    end

    it "render doctors/errors, when user creation failed" do
      post doctors_path(
        {
        name: user.name,
        email: nil,
      })
      expect(response).to render_template("doctors/_errors")
    end

    it "render doctors/errors, when doctor creation failed" do
      post doctors_path(
        {
        name: user.name,
        email: user.email,
        phone_number: "6765456765",
        years_of_experiance: "2",
        consultation_fee: nil,
        specialization_id: specialization.id

      })
      expect(response).to render_template("doctors/_errors")
    end

  end

  describe "PATCH /update" do    
    let(:user1) { FactoryBot.build(:user) }
    let(:doctor) {FactoryBot.create(:doctor)}
    let(:specialization) { FactoryBot.create(:specialization) }

    before(:each) do
      sign_in user1
    end 
    
    it "successfull updation" do 
      patch doctor_path(
        doctor,
        {
        name: "new_name",
        email: user1.email,
        phone_number: "6765456765",
        years_of_experiance: "2",
        consultation_fee: "150",
        specialization_id: specialization.id

      })
      #expect(response).to have_http_status(:success)
      expect(response).to render_template("admin/manage_doctors/_each_doctor")
    end

    it "user updation fail" do 
      patch doctor_path(
        doctor,
        {
          name: "new_name",
          email: user1.email,
          phone_number: "676",
          years_of_experiance: "2",
          consultation_fee: "150",
          specialization_id: specialization.id
      })
      expect(response).to render_template("doctors/_errors")
    end

    it "doctor updation fail" do 
      patch doctor_path(
        doctor,
        {
          name: "new_name",
          email: user1.email,
          phone_number: "6765456765",
          years_of_experiance: "2",
          consultation_fee: "1",
          specialization_id: specialization.id
      })
      expect(response).to render_template("doctors/_errors")
    end

    describe "GET /show" do
      let(:user) { FactoryBot.create(:user) }
      let(:doctor) { FactoryBot.create(:doctor) }
      before(:each) do
        sign_in(user)
      end
  
      it "is successful request" do
        get doctor_path(doctor)
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST /slots/display" do
      let(:user) { FactoryBot.create(:user) }
      let(:doctor) { FactoryBot.create(:doctor) }
      before(:each) do
        sign_in(user)
      end
  
      it "is successful request" do
        post slots_display_path(
          {
            selected_day: Time.now().day,
            id: doctor.id
          }
        )
         expect(response).to have_http_status(:success)
      end
    end

     
  end
end

