class AppointmentsController < ApplicationController 
    skip_before_action :verify_authenticity_token,only: %i[create]
    before_action :set_appointment, only: %i[show edit update destroy download]
    after_action :update_doctor_rating, only: [:update]

    def index
        @all_appointments = active_user.patient? ? active_user.patient.appointments.order(slot_time: :asc).paginate(page: params[:page], per_page: 10) : active_user.doctor.appointments.order(slot_time: :asc).paginate(page: params[:page], per_page: 10)
    end

    def create
        @appointment = Appointment.new(appointment_params.merge(patient_id:active_user.patient.id))
        if @appointment.save  
            redirect_to appointments_path,notice: "Appointment Booked Successfully"
        else
            redirect_to request.referer, alert: "Booking failed"
        end     
    end

    def show
        @status = @appointment.status
    end
    
    def update
        #debugger
          if @appointment.update(appointment_params)
            redirect_to request.referer, notice: "Appointment updated successfully"
          else
            redirect_to appointments_path, alert: "Appointment updation Failed"
          end
    end

    def download
        appointment_pdf = Services::AppointmentsService.new(@appointment).download
        if params[:preview].present?
          send_data(appointment_pdf.render, filename: "Medicare_#{current_user.name}_#{@appointment.slot_time}.pdf",
                    type: "application/pdf", disposition: 'inline')
        else
          send_data(appointment_pdf.render, filename: "Medicare_#{current_user.name}_#{@appointment.slot_time}.pdf",
                    type: "application/pdf")
        end 
    end

    private
      
    def appointment_params
        permitted_params = params.permit(:reason, :note , :status , :doctor_id ,:slot_time ,:feedback ,:rating)
        permitted_params[:rating] = permitted_params[:rating].to_i if permitted_params[:rating]
        permitted_params
    end
    
    def set_appointment
        @appointment = Appointment.find_by(id:params[:id])
    end

    def update_doctor_rating
        if @appointment.rating.present?
            new_rating = Appointment.where(doctor_id:@appointment.doctor_id).average(:rating)
            @doctor = Doctor.find_by(id:@appointment.doctor_id)
            @doctor.update(rating: new_rating)
        end
    end
end