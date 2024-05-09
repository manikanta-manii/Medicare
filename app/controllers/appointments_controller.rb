class AppointmentsController < ApplicationController 
    skip_before_action :verify_authenticity_token,only: %i[create]
    before_action :set_appointment, only: %i[show edit update destroy download]

    def index
        @all_appointments = active_user.patient? ? active_user.patient.appointments : active_user.doctor.appointments
    end

    def create
        # debugger
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
        params.permit(:reason, :note,:status , :doctor_id ,:slot_time )
    end

    def check_status_param
        params[:status].present?
    end

    def set_appointment
        @appointment = Appointment.find(params[:id])
    end
end