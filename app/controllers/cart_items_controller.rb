class CartItemsController < ApplicationController
    before_action :set_cart 
    def index
        @all_cart_items = @cart.cart_items
    end

    def new

    end

    def create
        price = Medicine.find(params[:medicine_id]).price
        if check_medicine(params[:medicine_id])
            @cart_item = @cart.cart_items.find_by(medicine_id:params[:medicine_id])
            new_quantity = @cart_item.quantity+=1
            new_total_price = price  * new_quantity
            @cart_item.update(quantity:new_quantity,total_price:new_total_price)
            
            
        else
            @cart.cart_items.create(medicine_id: params[:medicine_id],quantity: 1,total_price:price)
        end
        
    end

    private

    def set_cart
        user = current_user.patient
        @cart ||= (!user.cart.present?) ? user.create_cart! : user.cart
    end

    def check_medicine(medicine)
        @cart.cart_items.find_by(medicine_id:medicine) ? true : false
    end
end