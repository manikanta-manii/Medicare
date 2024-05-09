class OrderItemsController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create]
    before_action :set_order ,only: %i[create]

    def index
        
    end

    def new

    end

    def create

    end

    def destroy
   
    end
    
    private
    
    def set_order
        user = active_user.patient
        @order ||= (!user.order.present?) ? user.create_cart! : user.cart
    end

    def check_medicine(medicine)
        @cart.cart_items.find_by(medicine_id:medicine) ? true : false
    end 
end