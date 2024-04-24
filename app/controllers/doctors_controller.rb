class DoctorsController < ApplicationController
    before_action :authenticate_user! 
    skip_before_action :verify_authenticity_token
    def index
    
    end

    def show_appointments
        @all_appointments = current_user.doctor.appointments
    end
end
  