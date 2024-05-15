class OrdersController  < ApplicationController 
    before_action :authenticate_user!
    include ApplicationHelper
    include OrderItemsHelper
    include OrdersHelper
    before_action :set_address ,only: :update
    before_action :set_order ,only: [:update , :show]

    #displaying all the orders
    def index
        @all_orders = Order.paginate(page: params[:page], per_page: 10).where(ordered: true)
        @orders = active_user.patient.orders.where(ordered: true).paginate(page: params[:page], per_page: 10) if active_user.patient?
    end

    #displaying each order details
    def show
        @order_items = @order.order_items.includes(:medicine)
        @address = Address.find(@order.address_id)
    end

    #update the order - [status , address ,prescription if any?]
    def update
       if @address_id.nil?
            render plain:"not ok"
       else
            if check_medicine_availability(@order)
            medicines = check_need_prescription
            if medicines.count != 0
                    if params[:prescription] == "undefined"
                        render plain:"not ok"
                    else
                        new_total_price = get_total_price
                        @order.update(address_id:@address_id , total_price: new_total_price, ordered: true,prescription: params[:prescription]);
                        update_medicine_quantities(@order)
                        render plain: "ok"
                    end 
            else
                    @order.update(address_id:@address_id , total_price: get_total_price, ordered: true);
                    update_medicine_quantities(@order)
                    render plain:"ok"
            end
        end
    end

   end

   private
   
   #setting the address - [ new , old ]
   def set_address
      if params[:old] == "new"
         address = Address.create(address_params)
         @address_id = address.id
      else
        @address_id = params[:old].to_i
      end
   end
  
   #permitiing the address params
   def address_params
     params.require(:new).permit(:country,:state,:city,:street).merge(patient_id: active_user.patient.id)
   end

   #fiding the order by id
   def set_order
        @order = Order.find_by(id: params[:id])
   end

end
