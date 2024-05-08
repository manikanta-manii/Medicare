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
        selected_day=Time.now.day.to_i
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
        @slots = Services::SlotsService.new(params).display
    end

    def get_formated_date
        @formatted_dates =  Services::SlotsService.new.formatDates
    end

    def get_slots(selected_day)
        Services::SlotsService.new(slots: @slots,selected_day: selected_day).availableSlots
    end
end