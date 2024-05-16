class OrderItemsController < ApplicationController
   include OrderItemsHelper
   before_action :authenticate_user!
   before_action :set_order, only: [:create, :update, :destroy]
   before_action :find_order_item , only: [:update,:destroy]

   def index
     if order_exists
         @order = get_last_order
         @order_items = @order.order_items
     end
   end
 
   #creating the new order
   def create
     @order_item = @order.order_items.new(order_item_params)
     if @order_item.save
       redirect_to medicines_path, notice: "Item Added To Cart"
     else
      redirect_to root_path, alert: "Failed to Add"
     end
   end
  
   #quantity selector - INCREASE / DECREASE BY AJAX
   def update
     adjust_quantity(params[:quantity])
     render_total_price
   end
 
   #removing the order_item by AJAX
   def destroy
     @order_item.destroy
     render_destroy_response
   end
 
   private
 
   #permitting the order_items
   def order_item_params
      params.permit(:medicine_id, :price, :quantity).merge(quantity: 1)
   end
 
   #setting the order , only when creating , it creats new order only once !
   def set_order
     @order = current_order
   end
 
   #finding the order item
   def find_order_item
     @order_item = OrderItem.find_by(id: params[:id])
   end
 
   #calling the different functions based on params
   def adjust_quantity(quantity)
     if quantity == "increment"
       increment_quantity(@order_item)
     else
       decrement_quantity(@order_item)
     end
   end
  
   #incresing the quanitity - AJAX CALL
   def increment_quantity(order_item)
     new_price = order_item.medicine.price * (order_item.quantity + 1)
     order_item.update(price: new_price, quantity: order_item.quantity + 1)
    #  debugger
   end
 
   #decreasing the quanity - AJAX CALL
   def decrement_quantity(order_item) 
     new_price = order_item.medicine.price * (order_item.quantity - 1)
     order_item.update(price: new_price, quantity: order_item.quantity - 1)
   end

   #AJAX SENDING RESPONSE
   def render_total_price
     total_price = @order.order_items.sum(:price)
     render plain: total_price
   end
 
   #AJAX SENDING RESPONSE
   def render_destroy_response
     total_price = @order.order_items.sum(:price)
     total_price == 0 ? (render plain: "no items") : (render partial: "order_items/place_order")
   end

 end
 