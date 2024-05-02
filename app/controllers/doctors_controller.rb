class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create destroy]
    def index
        @doctors = Doctor.all.paginate(page: params[:page], per_page: 10)  
        @specializations = Specialization.all
    end
    def create
        @user = User.create(avatar:params[:avatar],name:params[:name],email:params[:email],password:"Doctor@123",phone_number:params[:phone_number],role:1)
        if @user.save
             @doctor = @user.create_doctor(years_of_experiance:params[:years_of_experience],consultation_fee:params[:consultation_fee],specialization_id:params[:specialization])
             render partial: "doctors/each_doctor",locals:{doc:@doctor}
        else
             render partial: "doctors/errors",locals:{user:@user}
        end
    end

    def destroy
         @user = User.find(params[:id]).destroy      
    end
    
    def detail
        
    end

    def show
        @all_appointments = current_user.doctor.appointments
    end

end