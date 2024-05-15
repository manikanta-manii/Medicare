module OrdersHelper
    def check_prescription_exists(order_items)
        if order_items.first.order.prescription.attached?
            yield
        end
    end

    def check_prescription_not_exists(order_items)
        unless order_items.first.order.prescription.attached?
            yield
        end
    end
end