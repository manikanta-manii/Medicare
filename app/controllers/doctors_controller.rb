class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :slot_allotment ,only: %i[show slot_display]
    before_action :get_formated_date ,only: %i[show]

    def index
        @q = Doctor.includes(:specialization , :user).ransack(params[:q])
        @doctors = @q.result(distinct: true)
        @specializations = Specialization.all
    end

    def create
        @user = User.new(avatar:params[:avatar],name:params[:name],email:params[:email],password:"Doctor@123",phone_number:params[:phone_number],role:1)
        if @user.save
             @doctor = @user.create_doctor(years_of_experiance:params[:years_of_experience],consultation_fee:params[:consultation_fee],specialization_id:params[:specialization])
             render partial: "doctors/each_doctor",locals:{doc:@doctor}
        else
             render partial: "doctors/errors",locals:{user:@user}
        end
    end

    def destroy
        User.find(params[:id]).destroy      
    end
    
    def show
        selected_day=Time.now().day.to_i 
        @available_slots = get_slots(selected_day)
    end

    def slot_display
        @selected_day = params[:selected_day]
        @available_slots = get_slots(@selected_day)
        render partial: "patients/slots_display"
    end

    private 

    def slot_allotment

        @doctor = Doctor.find_by(id:params[:id])
        @patient=current_user.patient
        
        @booked_slots = @doctor.appointments.where(status:"scheduled").pluck(:slot_time)
        @booked_slots = @booked_slots.map { |slot_time_str| Time.parse(slot_time_str) }

        current_time = Time.now
        start_date = Time.new(current_time.year, current_time.month, current_time.day, 8, 0, 0)
        end_date = start_date + 3.days

        exclude_times = @booked_slots.map do |booked_slot|
          exclusion_start_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min, 0)
          exclusion_end_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min + 1, 0)
          exclusion_start_time..exclusion_end_time
        end

        @slots = Slotty.get_slots(
        for_range: start_date..end_date,
        slot_length_mins: 30,
        interval_mins: 30,
        exclude_times: exclude_times
        ).pluck(:start_time)
        
        @slots.map{|el| el.to_time}
        @slots.reject!{ |slot| slot < current_time}
        @slots.reject!{ |slot| slot.strftime("%I:%M %p").to_time < "08:00 AM".to_time}

    end

    def get_formated_date
        @formatted_dates = []
        today = Date.today
        3.times do |i|
            date = today + i
            month_abbr = date.strftime("%b")
            day = date.day.to_s
            full_day_name = date.strftime("%A")  
            formatted_date = "#{full_day_name} #{month_abbr} #{day}, #{date.year}"
            @formatted_dates << formatted_date
        end
    end

    def get_slots(selected_day)
        i=0
        count=0
        available_slots=[]
        while i < @slots.length()
          if @slots[i].day == selected_day.to_i
              available_slots<<@slots[i]
          end
          i+=1
        end
        available_slots   
    end
end