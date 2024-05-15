class MedicinesController < ApplicationController
    before_action :authenticate_user! 
    skip_before_action :verify_authenticity_token, only: [:create ,:destroy ,:update]
    before_action :set_medicine, only: [:destroy , :update]
   
    #displaying all medicines
    def index
      @medicines = Medicine.all
    end

    #Adding a new medicine - AJAX
    def create
      @medicine = Medicine.new(medicine_params)
      if @medicine.save
        render partial: "medicines/each_medicine",locals:{medicine:@medicine}
      else
        render partial: "shared/errors",locals:{record:@medicine}
      end 
    end

    #updating the medicine Information - AJAX
    def update
      if @medicine.update(medicine_params)
        render partial: "admin/manage_medicines/each_medicine",locals:{medicine:@medicine}
      else
        render partial: "shared/errors",locals:{record:@medicine}
      end
    end

    #deleting the medicine
    def destroy
      if @medicine.destroy  
        render plain: "medicine deleted"
      else
        render plain: "medicine deletion failed"
      end    
    end

    private
    
    #finding the medicine by id
    def set_medicine
      @medicine = Medicine.find_by(id:params[:id])
    end

    #permiting the medicine params
    def medicine_params
      params.permit(:image,:name, :description,:dosage, :price,:need_prescription,:quantity)
    end

  end
  