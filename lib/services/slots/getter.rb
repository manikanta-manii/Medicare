module Services
    module Slots
        class Getter

            def initialize(params=nil)
                @params=params
            end

            def call
              #debugger
                i=0
                count=0
                available_slots=[]
                while i < @params[:slots].length()
                    if @params[:slots][i].day == @params[:selected_day].to_i
                        available_slots<<@params[:slots][i]
                    end
                i+=1
                end
            available_slots
            end  
        end
    end
end
