module Services
    module Slots
        class Getter

            def initialize(params=nil)
                @params=params
            end

            def self.call(slots,selected_day)
              #debugger
                i=0
                count=0
                available_slots=[]
                while i < slots.length()
                    if slots[i].day == selected_day.to_i
                        available_slots<<slots[i]
                    end
                i+=1
                end
            available_slots
            end  
        end
    end
end
