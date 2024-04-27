class ManageDoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create destroy]
    def index
    end
    def new
       @specializations = Specialization.all
       @doctors = Doctor.all
       
    end
    def create
        #debugger
        @user = User.create(avatar:params[:avatar],name:params[:name],email:params[:email],password:"Doctor@123",phone_number:params[:phone_number],role:1)
        if @user.save
             @doctor = @user.create_doctor(years_of_experiance:params[:years_of_experience],consultation_fee:params[:consultation_fee],specialization_id:params[:specialization])
             render partial: "manage_doctors/each_doctor",locals:{doc:@doctor}
        else
            render partial: "manage_doctors/errors",locals:{user:@user}
        end
    end

    def destroy
         @user = User.find(params[:id]).destroy
         
    end
end