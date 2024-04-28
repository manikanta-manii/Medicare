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
    end
end