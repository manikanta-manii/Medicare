module Services
    module Slots
      class Getter
        def initialize(params = nil)
          @params = params
        end
  
        def call
          selected_day = @params[:selected_day].to_i
          available_slots = @params[:slots].select { |slot| slot.day == selected_day }
          available_slots
        end
      end
    end
  end
  