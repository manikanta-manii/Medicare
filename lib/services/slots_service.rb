module Services
    class SlotsService
        def initialize(params=nil)
             @params=params
        end
        
        def display
            Services::Slots::Displayer.new(@params).call
        end
    end
end