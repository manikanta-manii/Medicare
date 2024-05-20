module Services
    module Orders
      class Updater
        def initialize(params=nil)
            @params = params
        end
  
        def call
            @address_id = set_address
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
  
        private
        def set_address
            if params[:old] == "new"
               address = Address.create(address_params)
               @address_id = address.id
            else
              @address_id = params[:old].to_i
            end
         end
           
      end
    end
  end
  