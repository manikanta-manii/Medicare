module Services
    module Appointments
        class Downloader
            def initialize(appointment=nil)
                @appointment=appointment
            end
            def call
                @doctor_name = @appointment.doctor.user.name
                @patient_name = @appointment.patient.user.name
                appointment_pdf = Prawn::Document.new
                appointment_pdf.font "Helvetica"
                appointment_pdf.font_size 12     
                appointment_pdf.text "Appointment Details", style: :bold, size: 16, align: :center
                appointment_pdf.move_down 10           
                appointment_pdf.text "Slot Time: #{@appointment.slot_time}", style: :italic
                appointment_pdf.text "Reason: #{@appointment.reason}", style: :italic
                appointment_pdf.text "Patient Name: #{@patient_name}", style: :italic
                appointment_pdf.text "Doctor Name: #{@doctor_name}", style: :italic       
                appointment_pdf.move_down 10
                appointment_pdf.text "Note:", style: :italic
                appointment_pdf.text @appointment.note.body.to_plain_text
                # debugger
                if @appointment.note.body.attachments.any?
                  image_attachment = @appointment.note.body.attachments.first
                  if image_attachment.image?
                    image_data = image_attachment.download
                    appointment_pdf.move_down 10
                    appointment_pdf.image StringIO.new(image_data), fit: [200, 200], position: :center
                  end
                end
                appointment_pdf
            end  
        end
    end
end
