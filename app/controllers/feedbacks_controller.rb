class FeedbacksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create]
  
    def create
      feedback_params = params.permit(:appointment_id, :rating, :review)
      @feedback = Feedback.new(feedback_params)
      if @feedback.save
        flash[:notice] = "Feedback Successfully Submitted!"
      else
        flash[:alert] = "Failed to Submit Feedback!"
      end
      render plain: "ok"
    end
  end
  