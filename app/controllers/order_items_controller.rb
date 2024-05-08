class OrderItemsController < ApplicationController
    before_action :set_order ,only: %i[create]

    def index
       
    end
    def new

    end
    def create
       debugger
    end
    
    def destroy
       
    end

    private

    def set_order
        user = current_user.patient
        @order ||= (!user.order.present?) ? user.create_order! : user.order
    end
  
end