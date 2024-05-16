module Services
    class SlotsService

        def initialize(params=nil)
             @params = params   
        end

        def display
            # debugger
            Services::Slots::Displayer.new(@params).call
        end
        
        def availableSlots
            Services::Slots::Getter.new(@params).call
        end

        def formatDates
            Services::Slots::DatesFormater.new.call
        end

    end
end