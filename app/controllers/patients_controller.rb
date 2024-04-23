class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_patient, only: [ :show ,:edit, :update, :destroy]
    skip_before_action :verify_authenticity_token
    before_action :slot_allotment ,only: %i[show_doctor_info slot_display]
  
    # GET /patients
    def index
      @all_doctors = Doctor.all
     
    end
  
    # GET /patients/1
    def show
        @all_doctors = Doctor.all
 
    end
  
    # GET /patients/new
    def new
      @patient = Patient.new
    end
  
    # GET /patients/1/edit
    def edit
    end
  
    # POST /patients
    def create
      @patient = Patient.new(patient_params)
  
      if @patient.save
        redirect_to @patient, notice: 'Patient was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /patients/1
    def update
      if @patient.update(patient_params)
        redirect_to @patient, notice: 'Patient was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /patients/1
    def destroy
      @patient.destroy
      redirect_to patients_url, notice: 'Patient was successfully destroyed.'
    end

    def show_doctor_info
      # @temp=@slots.reject!{ |slot| slot.strftime("%I:%M %p").to_time.day != @selected_day}
    end


    def book_appointment
       @appointment = Appointment.create(patient_id:params[:patient_id],doctor_id:params[:doctor_id],slot_time:params[:slot_time])
       if @appointment.save
        flash[:alert] = "BOOKED SUCCESFULLY"
        redirect_to root_path
       else
        flash[:alert] = "Booking failed"
        render :show_doctor_info
       end
    end

    def show_appointment
      @all_appointments = current_user.patient.appointments
    end
    def cancel_appointment
      @appointment = Appointment.find_by(id:params[:appointment_id])
      @appointment.update(status: "canceled")
      if @appointment.save
        flash[:alert] = "CANCELED APPOINTMENT !"
        redirect_to root_path
      else
        flash[:alert] = "Cancel failed !"
      end
    end

 def  slot_display
  @selected_day=params[:selected_day]
  i=0
  @count=0
  @temp=[]
  while i < @slots.length()
    if @slots[i].day == @selected_day.to_i
        @temp<<@slots[i]
    end
    i+=1
  end
  puts "%%%%%%%%%%%%%"
  puts @temp.length()
  render partial: "patients/slots_display"
 end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_patient
        @patient = Patient.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def patient_params
        params.require(:patient).permit(:name, :age, :gender, :email)
      end

      def slot_allotment
        @doctor = Doctor.find_by(id:params[:id])
        @patient=current_user.patient
        
        @booked_slots = @doctor.appointments.where(status:"active").pluck(:slot_time)
        @booked_slots.each_with_index do |slot_time_str, index|
             @booked_slots[index] = Time.parse(slot_time_str)
        end
        current_time = Time.now
        start_time = "08:00 AM".to_time
        exclude_times = @booked_slots.map do |booked_slot|
          exclusion_start_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min, 0)
          exclusion_end_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min + 1, 0)
          exclusion_start_time..exclusion_end_time
        end

        @slots = Slotty.get_slots(
        for_range: Time.new(current_time.year, current_time.month, current_time.day, 8, 0, 0)..Time.new(current_time.year, current_time.month, current_time.day+1, 24, 0, 0),
        slot_length_mins: 30,
        interval_mins: 30,
        exclude_times: exclude_times
        ).pluck(:start_time)
        
        @slots.map{|el| el.to_time}
        @slots.reject!{ |slot| slot < current_time}
        @slots.reject!{ |slot| slot.strftime("%I:%M %p").to_time < start_time.strftime("%I:%M %p").to_time}
      end
  end
  