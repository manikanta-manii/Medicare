class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:index, :show, :update]
    include ApplicationHelper
    include OrderItemsHelper
    include OrdersHelper
  
    before_action :set_address, only: :update
    before_action :set_order, only: [:update, :show]
  
    # Displaying all the orders
    def index
      #@all_orders = Order.where(ordered: true).paginate(page: params[:page], per_page: 10)
      @all_orders = Order.where(ordered: true).paginate(page: params[:page], per_page: 10).includes(patient: [:user])
      @orders = active_user.patient.orders.includes(prescription_attachment: [:blob]).where(ordered: true).paginate(page: params[:page], per_page: 10) if active_user.patient?
    end
  
    # Displaying each order details
    def show
      @order_items = @order.order_items.includes(:medicine)
      @address = Address.find_by(id: @order.address_id)
    end
  
    # Update the order - [status, address, prescription if any?]
    def update
      #  debugger
        unless valid_address?
            render plain: "not ok"
            return
        end
        if check_medicine_availability(@order)
            handle_if_medicine_available
        else
            render plain: "not ok"
        end
    end
  
    private

    def valid_address?
        !@address_id.nil?
    end

    def handle_if_medicine_available
        medicines = check_need_prescription
        if medicines.any?
            handle_update_with_prescription(params[:prescription])
        else
            handle_update_without_prescription
        end
    end
  
    # Setting the address - [new, old]
    def set_address
      if params[:old] == "new"
        @address_id = create_new_address
      else
        @address_id = params[:old].to_i
      end
    end
  
    def create_new_address
      address = Address.create(address_params)
      address.id
    end
  
    # Permitting the address params
    def address_params
      params.require(:new).permit(:country, :state, :city, :street).merge(patient_id: active_user.patient.id)
    end
  
    # Finding the order by id
    def set_order
      @order = Order.find_by(id: params[:id])
    end
    
    #update when prescription
    def handle_update_with_prescription(prescription)
      if prescription == "undefined"
        render plain: "not ok"
      else
        @order.update(address_id: @address_id, total_price: get_total_price, ordered: true, prescription: prescription)
        update_medicine_quantities(@order)
        render plain: "ok"
      end
    end
  
    #update when prescription is not there
    def handle_update_without_prescription
      @order.update(address_id: @address_id, total_price: get_total_price, ordered: true)
      update_medicine_quantities(@order)
      render plain: "ok"
    end
  end