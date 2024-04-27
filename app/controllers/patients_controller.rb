class PatientsController < ApplicationController
    def index
        @doctors = Doctor.all
        #@doctors = Doctor.all.paginate(page: params[:page], per_page: 10)  
    end
    def show
        @doctor = Doctor.find(params[:doctor_id])
    end
end