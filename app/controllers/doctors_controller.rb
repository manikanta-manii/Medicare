class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user! ,only: [:create , :update ,:destroy ]
    before_action :slot_allotment ,only: [:show , :slot_display]
    before_action :get_formated_date ,only: :show
    before_action :set_user ,only: [:update , :destroy] 
    
    #displaying all doctors
    def index
        @q = Doctor.includes(:specialization , :user).ransack(params[:q])
        @doctors = @q.result(distinct: true)
        @specializations = Specialization.all
    end

    #creating a new user of role: :doctor - AJAX call
    def create
        @user = User.new(user_params)
        if @user.save
            @doctor = @user.create_doctor(doctor_params)  
             if @doctor.save
                render partial: "doctors/each_doctor",locals: {doc:@doctor}
             else
                render_errors(@doctor)             
             end
        else
            render_errors(@user)
        end
    end

    #updating the doctor information - AJAX call
    def update
        if @user.update(user_params)
            if @doctor.update(doctor_params)
                render partial: "admin/manage_doctors/each_doctor",locals:{doc:@doctor}
            else
                render_errors(@doctor)
            end
        else
            render_errors(@user)
        end   
    end

    #deleting the doctor information - AJAX call
    def destroy
        if @user.destroy
            render plain:"deleted"
        else
            render plain:"deletion failed"
        end
    end
    
    #displaying particular doctor
    def show
        selected_day=Time.now.day.to_i
        @available_slots = get_slots(selected_day)
    end

    #slots display based on selected day - [ today , tomorrow , day_after_tomorrow ] - AJAX
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
    
    #business logic for getting the date in formatted way
    def get_formated_date
        @formatted_dates =  Services::SlotsService.new.formatDates
    end
    
    #business logic for getting the available slots
    def get_slots(selected_day)
        Services::SlotsService.new(slots: @slots,selected_day: selected_day).availableSlots
    end
    
    #permiting the dynamic params and merging with static params with value
    def user_params
        params.permit(:avatar, :name, :email, :phone_number).merge(password: "Doctor@123", role: 1)
    end
       
    #permitting the doctor params and converting the parmas to integer datatype
    def doctor_params
        permitted_params = params.permit(:years_of_experiance, :consultation_fee, :specialization_id)
        permitted_params[:years_of_experiance] = permitted_params[:years_of_experiance].to_i if permitted_params[:years_of_experiance]
        permitted_params[:consultation_fee] = permitted_params[:consultation_fee].to_i if permitted_params[:consultation_fee]
        permitted_params
    end
   
    #render the error patial for doctor / user
    def render_errors(record)
        render partial: "shared/errors", locals: { record: record }
    end
    
    #finding the doctor and user
    def set_user
        @doctor = Doctor.find_by(id: params[:id])
        @user = User.find_by(id: @doctor.user_id)
    end
       
end