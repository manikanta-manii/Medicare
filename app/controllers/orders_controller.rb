class OrdersController  < ApplicationController 
include ApplicationHelper
include OrderItemsHelper
    before_action :set_address ,only: [:update]

    def index
        @all_orders = Order.paginate(page: params[:page], per_page: 10)
        @orders = active_user.patient.orders if active_user.patient?
    end

    def show
        @order = Order.find(params[:id])
        @order_items = @order.order_items.includes(:medicine)
      end

   def update
    
       @order = Order.find_by(id: params[:id])
       if check_medicine_availability(@order)
       medicines = check_need_prescription
       if medicines.count!=0
            if params[:prescription] == "undefined"
                flash[:alert] = "Order place failed"
                render partial:"shared/flash_messages"
            else
                new_total_price = get_total_price
                @order.update(address_id:@address_id , total_price: new_total_price, ordered: true,prescription: params[:prescription]);
                flash[:notice] = "Order succesfully placed"
                render partial:"shared/flash_messages"
                update_medicine_quantities(@order)
            end           
       else
            @order.update(address_id:@address_id , total_price: get_total_price, ordered: true);
            flash[:notice] = "Order succesfully placed"
            render partial:"shared/flash_messages"
            update_medicine_quantities(@order)
       end
    end

   end

   private

   def set_address
      if params[:old] == "new"
         address = Address.create(country: params[:new][:country],state: params[:new][:state],city: params[:new][:city],street: params[:new][:street],patient_id:active_user.patient.id);
         @address_id = address.id
      else
        @address_id = params[:old].to_i
      end
   end

end
