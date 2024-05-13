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
    def check_if_current_user_is_doctor
        if active_user.doctor?
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

    def get_cart_total(order_items)
        order_items.pluck(:price).sum
    end

    def get_cart_items_count
        if active_user.patient && active_user.patient.orders.count!=0
            unless active_user.patient.orders.last.ordered
                @order =get_last_order
                return @order.order_items.count
            else
                return 0
            end
        else
            return 0
        end
    end
end
