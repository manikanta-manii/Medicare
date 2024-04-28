class FeedbacksController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create]

    def create
        feedback_rating= params[:rating].to_i
        appointment = Appointment.find(params[:appointment_id])
        @feedback = Feedback.create(appointment_id:params[:appointment_id],rating:feedback_rating,review:params[:review] )
        
        if @feedback.save  

            @doctor = appointment.doctor
            new_total_rating = @doctor.total_rating+=feedback_rating
            new_number_of_ratings = @doctor.number_of_ratings+=1
            new_rating = new_total_rating / new_number_of_ratings
            @doctor.update(total_rating:new_total_rating,number_of_ratings:new_number_of_ratings,rating:new_rating)
 
            flash[:notice] = "Feedback Suceesfully Submitted !"
          
        else
            flash[:alert] = "Failed to Submit Feedback !"
        end 
        render plain:"ook"  
    end
end