module ApplicationHelper
    def active_user
        @current_user ||= user_signed_in? ? current_user : nil
    end
end
