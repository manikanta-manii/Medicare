module OrderItemsHelper

    def current_order
         if active_user.patient.orders.where(:ordered == "false").count == 0
            order = active_user.patient.orders.new
            order.save
            order
         else
            order = active_user.patient.orders.last
         end
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

    def order_exists
        unless active_user.patient.orders.where(:ordered == "false").count == 0
            order = active_user.patient.orders.last
        end
    end

    def get_last_order
        order = active_user.patient.orders.last
    end

    def check_need_prescription
        medicines = []
        order = get_last_order
        order_items = order.order_items
        order_items.each do |item|
            if item.medicine.need_prescription
                medicines<<item.medicine.name
            end
        end
        medicines
    end

    def get_total_price
        order = get_last_order
        total_price = order.order_items.pluck(:price).sum
    end
end