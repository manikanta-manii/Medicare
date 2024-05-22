require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  let(:user_p) {FactoryBot.create(:user, role: 2)}
  let(:user_d) {FactoryBot.create(:user, role: 1)}
  let(:patient) {FactoryBot.create(:patient, user: user_p)}
  let(:doctor) {FactoryBot.create(:doctor, user: user_d)}
  let(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor)}
  
  describe "GET /index" do
   
    before(:each) do
      sign_in patient.user
    end
    
    it 'get appointments index page' do
      get appointments_path
      expect(response).to have_http_status(:success)
    end

  end

  describe "POST /create" do
    # let(:user_p) {FactoryBot.create(:user, role: 2)}
    # let(:user_d) {FactoryBot.create(:user, role: 1)}
    # let(:patient) {FactoryBot.create(:patient, user: user_p)}
    # let(:doctor) {FactoryBot.create(:doctor, user: user_d)}

    before(:each) do
      sign_in patient.user
    end 
    
    it "render doctors/each_doctor on success" do
      # debugger
      post appointments_path(
        {
        doctor_id: doctor.id,
        reason: "I have fever",
        status: "scheduled",
        slot_time: "2024-05-16 14:30:00 +0530",
        feedback: nil,
        rating: nil
      })
      expect(response).to redirect_to(appointments_path)
    end

    it "render same page if failure" do
      # debugger
      #invalid doctor-id
      post appointments_path(
        {
        doctor_id: 1111,
        reason: "I have fever",
        status: "scheduled",
        slot_time: "2024-05-16 14:30:00 +0530",
        feedback: nil,
        rating: nil
      })
      expect(response).to redirect_to(doctor_path(1111))
    end

  end

  describe "GET /show" do

    # let(:user_p) {FactoryBot.create(:user, role: 2)}
    # let(:user_d) {FactoryBot.create(:user, role: 1)}
    # let(:patient) {FactoryBot.create(:patient, user: user_p)}
    # let(:doctor) {FactoryBot.create(:doctor, user: user_d)}
    # let(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor)}

    before(:each) do
      sign_in patient.user
    end

    it "is successful request" do
      get appointment_path(appointment)
      expect(response).to have_http_status(:success)
    end

  end

  describe "PATCH /update" do    
    # let(:user_p) {FactoryBot.create(:user, role: 2)}
    # let(:user_d) {FactoryBot.create(:user, role: 1)}
    # let(:patient) {FactoryBot.create(:patient, user: user_p)}
    # let(:doctor) {FactoryBot.create(:doctor, user: user_d)}
    # let(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor)}

    before(:each) do
      sign_in patient.user
    end 
    
    it "successfull updation" do 
      patch appointment_path(
        appointment,
        {
          doctor_id: doctor.id,
          reason: "I have fever",
          status: "completed",
          slot_time: "2024-05-16 14:30:00 +0530",
          feedback: nil,
          rating: nil
      })
      # expect(response).to have_http_status(:success)
      expect(response).to redirect_to(appointment_path)
    end

    it "updation of doctor rating" do 
      patch appointment_path(
        appointment,
        {
          doctor_id: doctor.id,
          reason: "I have fever",
          status: "completed",
          slot_time: Time.now().to_s,
          feedback: "Good",
          rating: 5
      })
      # expect(response).to have_http_status(:success)
      expect(response).to redirect_to(appointment_path)
    end

    it "updation failure" do 
      patch appointment_path(
        appointment,
        {
          doctor_id: 11111,
          reason: "I have fever",
          status: "completed",
          slot_time: "2024-05-16 14:30:00 +0530",
          feedback: nil,
          rating: nil
      })
      # expect(response).to have_http_status(:success)
      expect(response).to redirect_to(appointments_path)
    end
end

describe "GET /download" do    
  # let(:user_p) {FactoryBot.create(:user, role: 2)}
  # let(:user_d) {FactoryBot.create(:user, role: 1)}
  # let(:patient) {FactoryBot.create(:patient, user: user_p)}
  # let(:doctor) {FactoryBot.create(:doctor, user: user_d)}
  let!(:appointment) {FactoryBot.create(:appointment, patient: patient, doctor: doctor,status: "completed",note:"paracetmol")}
  
  before(:each) do
    sign_in patient.user
  end 
  
  it "download with preview = true" do 
    get download_appointment_path(
      appointment,
      {
        preview: true
      }
    )
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq('application/pdf')
   response.headers['Content-Disposition'].split(";")[0] == "inline"
  end

  it "download without preview = false" do 
    get download_appointment_path(appointment)
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq('application/pdf')
    response.headers['Content-Disposition'].split(";")[0] == "attachment"
end

end
end
