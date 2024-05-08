class MedicinesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create ,:destroy]
  
    def index
      @medicine = Medicine.new
      @medicines = Medicine.all
      if current_user.patient && current_user.patient.cart.present?
        @cart = current_user.patient.cart
        @all_cart_items = @cart.cart_items
      end

    end
  
    def new
      @medicine = Medicine.new
    end
    def create
      @medicine = Medicine.new( image:params[:image],name:params[:name] , description:params[:description], dosage:params[:dosage], price:params[:price] , need_prescription:params[:need_prescription] , quantity: params[:quantity])
      if @medicine.save
        render partial: "medicines/each_medicine",locals:{medicine:@medicine}
      else
        render partial: "manage_doctors/errors",locals:{user:@medicine}
      end 
    end

    def destroy
      Medicine.find(params[:id]).destroy      
     end

    private
    
    def medicine_params
      params.require(:medicine).permit(:image,:name, :description,:dosage, :price,:need_prescription)
    end
  end
  