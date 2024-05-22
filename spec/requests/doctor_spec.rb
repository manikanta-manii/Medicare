require 'rails_helper'

RSpec.describe "Doctors", type: :request do

  describe "GET /index" do
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
    let(:user) { FactoryBot.build(:user,role: 0)}
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
      expect(response).to render_template("shared/_errors")
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
      expect(response).to render_template("shared/_errors")
    end

  end

  describe "PATCH /update" do    
    let(:user1) { FactoryBot.build(:user,role: 0) }
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
      expect(response).to render_template("shared/_errors")
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
      expect(response).to render_template("shared/_errors")
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
      let(:user_p) {FactoryBot.create(:user, role: 2)}
      let(:patient) {FactoryBot.create(:patient, user: user_p)}
      let(:user_d) { FactoryBot.create(:user,role: 1) }
      let(:doctor) { FactoryBot.create(:doctor,user: user_d) }
      let!(:appointment) { FactoryBot.create(:appointment,doctor: doctor,patient: patient)}
      before(:each) do
        sign_in(patient.user)
      end
      it "is successful request" do
        post slots_display_path(doctor,
          {
            selected_day: Time.now().day,
            id: doctor.id
          }
        )
         expect(response).to have_http_status(:success)
      end
    end

     
  end

  describe "DELETE /destroy" do
    let(:admin) { FactoryBot.build(:user, role: 0)}
    let(:user_d) { FactoryBot.create(:user,role: 1) }
    let(:doctor) { FactoryBot.create(:doctor, user: user_d)}
    before(:each) do
      sign_in admin
    end 
    
    it "medicine deletion on success" do
      delete doctor_path(
        doctor
        )
        expect(response).to have_http_status(200)
        expect(response.body).to eq("deleted")
    end

    it "does not destroy the medicine if deletion fails" do
      doctor
      allow_any_instance_of(Doctor).to receive(:destroy).and_return(false)
      expect {
        delete doctor_path(doctor)
      }.to_not change(Doctor, :count)

      expect(response).to have_http_status(200)
      expect(response.body).to eq("deletion failed")
    end
  end

end

