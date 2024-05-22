class AppointmentsController < ApplicationController 
    before_action :authenticate_user!
    before_action :set_appointment, expect: [:create , :index]
    after_action :update_doctor_rating, only: :update
    skip_before_action :verify_authenticity_token,only: :create
    
    # displaying all appointments - based on active_user
    def index
        @all_appointments = active_user.patient? ? active_user.patient.appointments.order(slot_time: :asc).paginate(page: params[:page], per_page: 10) : active_user.doctor.appointments.order(slot_time: :asc).paginate(page: params[:page], per_page: 10)
    end
    
    #creating a new appointment
    def create
        @appointment = Appointment.new(appointment_params.merge(patient_id:active_user.patient.id))
        if @appointment.save
            AppointmentConfirmationMailer.appointment_confirmation_email(@appointment).deliver_later
            redirect_to appointments_path,notice: "Appointment Booked Successfully"
        else
            redirect_to doctor_path(params[:doctor_id]), alert: "Booking failed"
        end 
    end
    
    #appointment show path
    def show
        @status = @appointment.status
    end

    #updating the appointment - [REASON ,PRESCRIPTION]
    def update
          if @appointment.update(appointment_params)
            redirect_to appointment_path, notice: "Appointment updated successfully"
          else
            redirect_to appointments_path, alert: "Appointment updation Failed"
          end
    end

    #download the appointment details
    def download
        appointment_pdf = Services::AppointmentsService.new(@appointment).download
        filename = "Medicare_#{current_user.name}_#{@appointment.slot_time}.pdf"
        send_data(appointment_pdf.render, filename: filename, type: "application/pdf", disposition: params[:preview].present? ? 'inline' : 'attachment')
    end
      
    private
    #permiting the appointment params and converting rating to integer
    def appointment_params
        permitted_params = params.permit(:reason, :note , :status , :doctor_id ,:slot_time ,:feedback ,:rating)
        permitted_params[:rating] = permitted_params[:rating].to_i if permitted_params[:rating]
        permitted_params
    end
    
    #finding the appointment by id
    def set_appointment
        @appointment = Appointment.find_by(id: params[:id])
    end

    #updating the doctor rating
    def update_doctor_rating
        if @appointment.rating.present?
            new_rating = Appointment.where(doctor_id:@appointment.doctor_id).average(:rating)
            @doctor = @appointment.doctor
            @doctor.update(rating: new_rating)
        end
    end
end