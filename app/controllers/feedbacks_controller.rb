class FeedbacksController < ApplicationController
    skip_before_action :verify_authenticity_token,only: %i[create]

    def create
        @feedback = Feedback.create(appointment_id:params[:appointment_id],rating:params[:rating],review:params[:review] )
        if @feedback.save
            flash[:notice] = "Feedback Suceesfully Submitted !"
        else
            flash[:alert] = "Failed to Submit Feedback !"
        end 
        render plain:"ook"  
    end
end