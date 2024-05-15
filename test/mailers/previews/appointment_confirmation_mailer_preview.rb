# Preview all emails at http://localhost:3000/rails/mailers/appointment_confirmation_mailer
class AppointmentConfirmationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/appointment_confirmation_mailer/appointment_confirmation_email
  def appointment_confirmation_email
    AppointmentConfirmationMailer.appointment_confirmation_email
  end

end
