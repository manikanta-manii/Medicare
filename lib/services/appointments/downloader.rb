module Services
    module Appointments
      class Downloader
        def initialize(appointment=nil)
          @appointment = appointment
        end
  
        def call
          generate_pdf
        end
  
        private
  
        def generate_pdf
          appointment_pdf = Prawn::Document.new
          configure_pdf(appointment_pdf)
          add_appointment_details(appointment_pdf)
          add_note_details(appointment_pdf)
          add_attachment(appointment_pdf)
          appointment_pdf
        end
  
        def configure_pdf(pdf)
          pdf.font "Helvetica"
          pdf.font_size 12
        end
  
        def add_appointment_details(pdf)
          pdf.text "Appointment Details", style: :bold, size: 16, align: :center
          pdf.move_down 10
          pdf.text "Slot Time: #{@appointment.slot_time}", style: :italic
          pdf.text "Reason: #{@appointment.reason}", style: :italic
          pdf.text "Patient Name: #{patient_name}", style: :italic
          pdf.text "Doctor Name: #{doctor_name}", style: :italic
          pdf.move_down 10
        end
  
        def add_note_details(pdf)
          pdf.text "Prescription:", style: :italic
          pdf.text @appointment.note.body.to_plain_text
        end
  
        def add_attachment(pdf)
          image_attachment = @appointment.note.body.attachments.first
          return unless image_attachment&.image?
  
          image_data = image_attachment.download
          pdf.move_down 10
          pdf.image StringIO.new(image_data), fit: [200, 200], position: :center
        end
  
        def patient_name
          @appointment.patient.user.name
        end
  
        def doctor_name
          @appointment.doctor.user.name
        end
      end
    end
  end
  