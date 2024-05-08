module ApplicationHelper

    def active_user
        @current_user ||= user_signed_in? ? current_user : nil
    end

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

    def render_profile_pic_if_attached(user)
        if user.avatar.attached?
            yield
        end
    end

    def render_default_pic_if_profile_pic_not_attached(user)
        unless user.avatar.attached?
            yield
        end
    end
    
end
