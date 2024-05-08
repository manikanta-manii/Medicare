class AppointmentsController < ApplicationController 
    skip_before_action :verify_authenticity_token,only: %i[create]
    before_action :set_appointment, only: %i[show edit update destroy download]

    def index
        @all_appointments = current_user.patient? ? current_user.patient.appointments : current_user.doctor.appointments
    end

    def new
    end

    def create 
        @appointment = Appointment.new(patient_id:current_user.patient.id , doctor_id:params[:doctor_id] , slot_time:params[:slot_time] , reason:params[:reason] )
        if @appointment.save
            flash[:notice] = "Appointment Booked Successfully"    
            redirect_to appointments_path
        else
            flash[:alert] = "Booking Failed"
            redirect_to request.referer
        end     
    end

    def show
        @status = @appointment.status
    end
    
    def destroy
        @appointment.update(status:"canceled")
        redirect_to appointments_path,notice: "Appointment canceled Succesfully !"
        #TRIGER MAIL !
    end

    def edit
    end

    def update
        debugger
        if check_status_param
            @appointment.update(status:params[:status])
            redirect_to appointments_path, notice: "Appointment updated successfully"
        else
          if @appointment.update(appointment_params)
             redirect_to appointments_path, notice: "Appointment updated successfully"
          else
            redirect_to appointments_path, alert: "Appointment updation Failed"
          end
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
        params.require(:appointment).permit(:reason, :note,:status)
    end

    def check_status_param
        params[:status].present?
    end

    def set_appointment
        @appointment = Appointment.find(params[:id])
    end
end