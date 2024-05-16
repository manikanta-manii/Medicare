module Services
    module Slots
        class Displayer
            def initialize(params=nil)
                @params=params
            end
            def call
                # debugger
                doctor = Doctor.find_by(id:@params[:id])         
                booked_slots = doctor.appointments.where(status:"scheduled").pluck(:slot_time)
                booked_slots = booked_slots.map { |slot_time_str| Time.parse(slot_time_str) }
                current_time = Time.now
                start_date = Time.new(current_time.year, current_time.month, current_time.day, 8, 0, 0)
                end_date = start_date + 3.days
                
                exclude_times = booked_slots.map do |booked_slot|
                #   debugger
                  exclusion_start_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min, 0)
                  exclusion_end_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min + 1, 0)
                  exclusion_start_time..exclusion_end_time
                end
        
                slots = Slotty.get_slots(
                for_range: start_date..end_date,
                slot_length_mins: 30,
                interval_mins: 30,
                exclude_times: exclude_times
                ).pluck(:start_time)
                
                slots.map{|el| el.to_time}
                slots.reject!{ |slot| slot < current_time}
                slots.reject!{ |slot| slot.strftime("%I:%M %p").to_time < "08:00 AM".to_time}
                slots
            end  
        end
    end
end
