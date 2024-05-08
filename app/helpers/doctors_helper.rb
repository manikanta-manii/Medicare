module DoctorsHelper
    def check_if_current_user_is_admin
        if active_user.admin?
            yield
        end
    end

    def check_if_current_user_is_patient
        if active_user.patient?
            yield
        end
    end
end