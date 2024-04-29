class AppointmentsController < ApplicationController 
    skip_before_action :verify_authenticity_token,only: %i[create]
    def new 
    end

    def create
        @appointment = Appointment.create( patient_id:current_user.patient.id , doctor_id:params[:doctor_id] , slot_time:params[:slot_time] , reason:params[:reason] )
        if @appointment.save
            flash[:notice] = "Appointment Booked Successfully , Confirmation sent to your Gmail !"    
        else
            flash[:alert] = "Booking Failed ! , You Must provide Reason for booking !"
        end
    end

    def show
        @all_appointments = current_user.patient.appointments
    end
    

    def details
        @status = params[:status]
        @appointment_id = params[:appointment_obj]
        @appointment = Appointment.find(@appointment_id)
    end

    def destroy
        @appointment = Appointment.find(params[:id])
        @appointment.update(status:"canceled")
        flash[:notice] = "Appointment canceled Succesfully !"
        redirect_to @appointment
        #TRIGER MAIL !
    
    end

    def download
        @appointment = Appointment.find(params[:id])

        @doctor = Doctor.find(@appointment.doctor_id)

        @doctor_name  =User.find(@doctor.user_id).name

        
        
        appointment_pdf = Prawn::Document.new
        appointment_pdf.text @appointment.slot_time
        appointment_pdf.text @appointment.reason
        appointment_pdf.text current_user.name
        appointment_pdf.text @doctor_name

       if params[:preview].present?
        send_data(appointment_pdf.render, filename: "Medicare_#{current_user.name}_#{@appointment.slot_time}.pdf",type: "application/pdf",disposition: 'inline')
       else
        send_data(appointment_pdf.render, filename: "Medicare_#{current_user.name}_#{@appointment.slot_time}.pdf",type: "application/pdf")
       end
    end

    def update
        debugger
    end
     

    
end