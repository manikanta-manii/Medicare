module OrderItemsHelper

    def current_order
         if active_user.patient.orders.where(:ordered == "false").count == 0
            order = active_user.patient.orders.new
            order.save
            order
         else
            order = active_user.patient.orders.last
         end
        session[:order_id] = order.id
        order = Order.find_by(id: session[:order_id])
    end

    def if_medicine_exist(med_id)
        orders = Order.where(patient_id: active_user.patient.id)
        unless orders.where(:ordered == "false").count == 0
            if active_user.patient.orders.last.order_items.where(medicine_id: med_id).count == 0
                return false
            else
                return true
            end
        end
    end
end