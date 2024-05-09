module AppointmentsHelper
    def check_if_status_is_scheduled(appointment)
        if appointment.status == "scheduled"
            yield
        end
    end
    def check_if_status_is_completed(appointment)
        if appointment.status == "completed"
            yield
        end
    end
    def check_if_status_is_canceled(appointment)
        if appointment.status == "canceled"
            yield
        end
    end
    def check_if_feedback_is_present(appointment)
        if appointment.feedback.present?
            yield
        end
    end
    def check_if_feedback_is_not_present(appointment)
        unless appointment.feedback.present?
            yield
        end
    end
    
    def check_if_note_is_present(appointment)
        if appointment.note.present?
            yield
        end
    end

    def check_if_note_is_not_present(appointment)
        unless appointment.note.present?
            yield
        end
    end

end
  