module Services
    module Slots
        class DatesFormater
            
            def initialize(params=nil)
                @params=params
            end

            def call
                formatted_dates = []
                today = Date.today
                3.times do |i|
                    date = today + i
                    month_abbr = date.strftime("%b")
                    day = date.day.to_s
                    full_day_name = date.strftime("%A")  
                    formatted_date = "#{full_day_name} #{month_abbr} #{day}, #{date.year}"
                    formatted_dates << formatted_date
                end
                formatted_dates
            end  
        end
    end
end
