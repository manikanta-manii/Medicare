class OrderItemsController < ApplicationController
   before_action :set_order , only: [:create]

   def create
      # debugger
      # @order_item = @order.order_items.new(medicine_id: params[:medicine_id],price: params[:price],quantity:1)
      # if @order_item.save
      #   redirect_to request.referer, notice: "Item Added To Cart"
      # else
      #   redirect_to request.referer, alert: "Failed to Add"
      # end
   end

   def update
      debugger
   end

   def destroy
    
   end

   def set_order
      if active_user.patient.orders.where(:ordered == "false").count == 0
         @order = active_user.patient.orders.new
         @order.save
         @order
      else
         @order = active_user.patient.orders.last
      end
   end
end