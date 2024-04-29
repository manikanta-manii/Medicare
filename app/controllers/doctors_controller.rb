class DoctorsController < ApplicationController

    def detail
        
    end
    def show
        @all_appointments = current_user.doctor.appointments
    end
end