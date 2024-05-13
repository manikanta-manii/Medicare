class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    before_action :slot_allotment ,only: %i[show slot_display]
    before_action :get_formated_date ,only: %i[show]
    before_action :set_user ,only: %i[update destroy] 

    def index
        @q = Doctor.includes(:specialization , :user).ransack(params[:q])
        @doctors = @q.result(distinct: true)
        @specializations = Specialization.all
    end

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

    def destroy
        @user.destroy
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
    
    def user_params
        params.permit(:avatar, :name, :email, :phone_number).merge(password: "Doctor@123", role: 1)
    end
       
    def doctor_params
        permitted_params = params.permit(:years_of_experiance, :consultation_fee, :specialization_id)
        permitted_params[:years_of_experiance] = permitted_params[:years_of_experiance].to_i if permitted_params[:years_of_experiance]
        permitted_params[:consultation_fee] = permitted_params[:consultation_fee].to_i if permitted_params[:consultation_fee]
        permitted_params
    end

    def render_errors(record)
        render partial: "doctors/errors", locals: { record: record }
    end

    def set_user
        @doctor = Doctor.find_by(id: params[:id])
        @user = User.find_by(id: @doctor.user_id)
    end
       
end