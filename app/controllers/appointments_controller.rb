class AppointmentsController < ApplicationController 
    skip_before_action :verify_authenticity_token,only: %i[create]

    def index
        if current_user.patient?
           @all_appointments = current_user.patient.appointments
        end
        if current_user.doctor?
            @all_appointments = current_user.doctor.appointments
        end
    end

    def new 
    end

    def create
        @appointment = Appointment.create( patient_id:current_user.patient.id , doctor_id:params[:doctor_id] , slot_time:params[:slot_time] , reason:params[:reason] )
        if @appointment.save
            flash[:notice] = "Appointment Booked Successfully , Confirmation sent to your Gmail !"    
            redirect_to appointments_path
        else
            flash[:alert] = "Booking Failed ! , You Must provide Reason for booking !"
            redirect_to request.referer
        end  
        #TRIGER MAIL !    
    end

    def show
        
        @appointment = Appointment.find(params[:id])
        @status = @appointment.status
    end
    
    def destroy
        @appointment = Appointment.find(params[:id])
        @appointment.update(status:"canceled")
        flash[:notice] = "Appointment canceled Succesfully !"
        redirect_to appointments_path
        #TRIGER MAIL !
    end
    def edit
        @appointment = Appointment.find(params[:id])
    end
    def update
        @appointment = Appointment.find(params[:id])
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
        #redirect_to appointments_path, notice: "Appointment updated successfully"

    end
    def download
        @appointment = Appointment.find(params[:id])
        @doctor = Doctor.find(@appointment.doctor_id)
        @doctor_name = User.find(@doctor.user_id).name
      
        appointment_pdf = Prawn::Document.new

        appointment_pdf.font "Helvetica"
        appointment_pdf.font_size 12

        appointment_pdf.text "Appointment Details", style: :bold, size: 16, align: :center
        appointment_pdf.move_down 10
      
        appointment_pdf.text "Slot Time: #{@appointment.slot_time}", style: :italic
        appointment_pdf.text "Reason: #{@appointment.reason}", style: :italic
        appointment_pdf.text "Patient Name: #{current_user.name}", style: :italic
        appointment_pdf.text "Doctor Name: #{@doctor_name}", style: :italic
      
        # Extract plain text from ActionText rich text
        appointment_pdf.move_down 10
        appointment_pdf.text "Note:", style: :italic
        appointment_pdf.text @appointment.note.body.to_plain_text
      
        # Check if there's an image attachment
        if @appointment.note.body.attachments.any?
          image_attachment = @appointment.note.body.attachments.first
          if image_attachment.image?
            # Embed the image in the PDF
            image_data = image_attachment.download
            appointment_pdf.move_down 10
            appointment_pdf.image StringIO.new(image_data), fit: [200, 200], position: :center
          end
        end
      
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
end