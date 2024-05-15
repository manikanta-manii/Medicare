class AppointmentConfirmationMailer < ApplicationMailer
  def appointment_confirmation_email(appointment)
      @greeting = "Hii"
      @patient_name = appointment.patient.user.name
      @doctor_name = appointment.doctor.user.name
      @slot_time = appointment.slot_time
      mail(from: "karna8722@gmail.com",to: appointment.patient.user.email ,subject: "Medicare- Doctor Appointment") 
  end
end
