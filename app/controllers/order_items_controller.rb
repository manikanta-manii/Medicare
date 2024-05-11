class OrderItemsController < ApplicationController

   include OrderItemsHelper
   before_action :set_order , only: [:create]

   def index
      if order_exists
         @order = get_last_order
         @order_items = @order.order_items
      end
   end

   def create
      # debugger
      @order_item = @order.order_items.new(medicine_id: params[:medicine_id],price: params[:price],quantity:1)
      if @order_item.save
        redirect_to request.referer, notice: "Item Added To Cart"
      else
        redirect_to request.referer, alert: "Failed to Add"
      end
   end

   def update
      #  debugger
      @order_item = OrderItem.find_by(id: params[:id])
      @order = Order.find_by(id: @order_item.order_id)

      if params[:quantity] == "increment"
         increment_quantity(@order_item)
      else
         decrement_quantity(@order_item)
      end
      total_price = @order.order_items.pluck(:price).sum
      render plain:total_price
   end

   def destroy
     @order_item = OrderItem.find_by(id: params[:id])
      @order = Order.find_by(id: @order_item.order_id)
     @order_item.destroy
     total_price = @order.order_items.pluck(:price).sum
      render partial:"order_items/place_order"
   end
  
   private

   def set_order
      @order = current_order
   end

   def increment_quantity(order_item)
      new_price = (order_item.medicine.price * (order_item.quantity+1))
      order_item.update(price: new_price , quantity: (order_item.quantity+1))   
   end

   def decrement_quantity(order_item)
      new_price = (order_item.medicine.price * (order_item.quantity-1))
      order_item.update(price: new_price , quantity: (order_item.quantity-1)) 
   end
end