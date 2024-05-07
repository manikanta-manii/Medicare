module Services
    class SlotsService
        def initialize(params=nil)
             @params = params
      
        end
        
        def display
            Services::Slots::Displayer.new(@params).call
        end

        def availableSlots
            Services::Slots::Getter.call(@params[:slots],@params[:selected_day])
        end

        def formatDates
            Services::Slots::Formater.call
        end

    end
end