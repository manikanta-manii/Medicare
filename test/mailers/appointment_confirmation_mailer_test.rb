require "test_helper"

class AppointmentConfirmationMailerTest < ActionMailer::TestCase
  test "appointment_confirmation_email" do
    mail = AppointmentConfirmationMailer.appointment_confirmation_email
    assert_equal "Appointment confirmation email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
