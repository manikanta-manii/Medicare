module OrderItemsHelper

    def current_order
        if active_user.patient && active_user.patient.orders.count!=0
            if active_user.patient.orders.last.ordered
                order = active_user.patient.orders.new
                order.save
                order
            else
                order = active_user.patient.orders.last
            end
        else
            order = active_user.patient.orders.new
            order.save
            order
        end
    end

    def if_medicine_exist(med_id)
        if order_exists
            if active_user.patient && active_user.patient.orders.last.order_items.where(medicine_id: med_id).count == 0
                return false
            else
                return true
            end
        else
            return false
        end
    end

    def order_exists
        if active_user.patient && active_user.patient.orders.count!=0
            unless active_user.patient.orders.last.ordered
                 order = active_user.patient.orders.last
            end
        end
    end

    def get_last_order
        order = active_user.patient.orders.last
    end

    def get_order_id
        order = get_last_order
        order.id
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

    def check_medicine_availability(order)
        order.order_items.each do |order_item|
          # Check if medicine quantity is available in inventory
          return false if order_item.medicine.quantity < order_item.quantity
        end
        true
      end
    
      def update_medicine_quantities(order)
        order.order_items.each do |order_item|
          # Reduce medicine quantity in inventory
          medicine = order_item.medicine
          medicine.update(quantity: medicine.quantity - order_item.quantity)
        end
      end
end