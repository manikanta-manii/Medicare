module Services
    class OrdersService

        def initialize(params=nil)
             @params = params   
        end

        def update
            Services::Orders::Updater.new(@params).call
        end
        
    end
end