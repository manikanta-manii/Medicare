class FeedbacksController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create]
  
    def create
      @feedback = Feedback.new(feedback_params)
      if @feedback.save
        flash[:notice] = "Feedback Successfully Submitted!"
      else
        flash[:alert] = "Failed to Submit Feedback!"
      end
    end

    private 

    def feedback_params
      params.permit(:appointment_id, :rating, :review)
    end

  end
  