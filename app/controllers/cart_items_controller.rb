class CartItemsController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create]
    before_action :set_cart ,only: %i[create]

    def index
        if current_user.patient.cart.present?
            @cart = current_user.patient.cart;
            @all_cart_items = @cart.cart_items
            @total_prices = @cart.cart_items.pluck(:total_price)
        end
    end

    def new

    end

    def create
         medicine =  Medicine.find(params[:medicine_id])
         price = medicine.price
        if check_medicine(params[:medicine_id])
              @cart_item = @cart.cart_items.find_by(medicine_id:params[:medicine_id])
              new_quantity =params[:medicine_quantity].to_i
              new_total_price = price  * new_quantity
              @cart_item.update(quantity:new_quantity,total_price:new_total_price)
        else
            new_total_price = price * params[:medicine_quantity].to_i
            @cart.cart_items.create(medicine_id: params[:medicine_id],quantity:params[:medicine_quantity].to_i ,total_price:new_total_price)
        end
        new_total_price = @cart.cart_items.pluck(:total_price).reduce(0, :+)
        @cart.update(total_price: new_total_price)
        render plain:"#{@cart.cart_items.count}"
    end

    def destroy
        CartItem.find(params[:id]).destroy
        redirect_to cart_items_path,notice: "Item Removed from the cart !"    
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