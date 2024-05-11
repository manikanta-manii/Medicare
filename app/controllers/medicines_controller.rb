class MedicinesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create ,:destroy ,:update]
    before_action :set_medicine, only: [:destroy , :update]

    def index
      @medicines = Medicine.all
    end

    def create
      @medicine = Medicine.new(medicine_params)
      if @medicine.save
        render partial: "medicines/each_medicine",locals:{medicine:@medicine}
      else
        render partial: "shared/errors",locals:{record:@medicine}
      end 
    end

    def update
      @medicine.update(medicine_params)
      render partial: "admin/manage_medicines/each_medicine",locals:{medicine:@medicine}
    end

    def destroy
      @medicine.destroy      
    end

    private
    
    def set_medicine
      @medicine = Medicine.find_by(id:params[:id])
    end

    def medicine_params
      params.permit(:image,:name, :description,:dosage, :price,:need_prescription,:quantity)
    end
  end
  