require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe 'GET /appointments' do

    it 'redirects to sign in page if user is not signed in' do
      get '/appointments'
      debugger
      expect(response).to redirect_to(new_user_session_path)
    end

    # context 'when user is signed in' do
    #   let(:user) { create(:user) }
    #   let(:patient) { create(:patient, user: user) }
    #   let(:doctor) { create(:doctor, user: user) }
    #   let(:appointment) { create(:appointment, patient: patient, doctor: doctor) }

    #   before { sign_in user }

    #   it 'returns http success' do
    #     get '/appointments'
    #     expect(response).to have_http_status(:success)
    #   end
    # end
  end

  # describe 'POST /appointments' do
  #   context 'when user is signed in' do
  #     let(:user) { create(:user) }
  #     let(:patient) { create(:patient, user: user) }
  #     let(:doctor) { create(:doctor, user: user) }

  #     before { sign_in user }

  #     context 'with valid attributes' do
  #       it 'creates a new appointment' do
  #         appointment_attributes = attributes_for(:appointment, patient_id: patient.id, doctor_id: doctor.id)
  #         expect {
  #           post '/appointments', params: { appointment: appointment_attributes }
  #         }.to change(Appointment, :count).by(1)
  #       end

  #       it 'redirects to appointments path' do
  #         appointment_attributes = attributes_for(:appointment, patient_id: patient.id, doctor_id: doctor.id)
  #         post '/appointments', params: { appointment: appointment_attributes }
  #         expect(response).to redirect_to(appointments_path)
  #       end
  #     end

  #     context 'with invalid attributes' do
  #       it 'does not save the new appointment' do
  #         appointment_attributes = attributes_for(:appointment, patient_id: nil, doctor_id: nil)
  #         expect {
  #           post '/appointments', params: { appointment: appointment_attributes }
  #         }.to_not change(Appointment, :count)
  #       end

  #       it 'redirects to previous page' do
  #         appointment_attributes = attributes_for(:appointment, patient_id: nil, doctor_id: nil)
  #         post '/appointments', params: { appointment: appointment_attributes }
  #         expect(response).to redirect_to(request.referer)
  #       end
  #     end
  #   end
  # end

  # describe 'GET /appointments/:id' do
  #   it 'redirects to sign in page if user is not signed in' do
  #     appointment = create(:appointment)
  #     get "/appointments/#{appointment.id}"
  #     expect(response).to redirect_to(new_user_session_path)
  #   end

  #   context 'when user is signed in' do
  #     let(:user) { create(:user) }
  #     let(:patient) { create(:patient, user: user) }
  #     let(:doctor) { create(:doctor, user: user) }
  #     let(:appointment) { create(:appointment, patient: patient, doctor: doctor) }

  #     before { sign_in user }

  #     it 'returns http success' do
  #       get "/appointments/#{appointment.id}"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end
  # end

  # describe 'PATCH /appointments/:id' do
  #   # Add tests for update action here
  # end

  # describe 'GET /appointments/:id/download' do
  #   # Add tests for download action here
  # end
end
