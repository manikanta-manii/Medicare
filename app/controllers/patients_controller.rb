class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_patient, only: [ :show ,:edit, :update, :destroy]
  
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
        
        puts "#######################################"
        puts params
        @doctor = Doctor.find_by(id:params[:id])
        @patient=current_user.patient
        
       @booked_slots = @doctor.appointments.where(status:"active").pluck(:slot_time)
       @booked_slots.each_with_index do |slot_time_str, index|
        @booked_slots[index] = Time.parse(slot_time_str)
      end

        # @available_slots =
        # @ex_hr=9
      # Current time
        current_time = Time.now
       

        # Define exclusion time range
      
        exclude_times = @booked_slots.map do |booked_slot|
          exclusion_start_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min, 0)
          exclusion_end_time = Time.new(booked_slot.year, booked_slot.month, booked_slot.day, booked_slot.hour, booked_slot.min + 1, 0)
          exclusion_start_time..exclusion_end_time
        end
        @slots = Slotty.get_slots(
        for_range: Time.new(current_time.year, current_time.month, current_time.day, 6, 0, 0)..Time.new(current_time.year, current_time.month, current_time.day, 24, 0, 0),
        slot_length_mins: 30,
        interval_mins: 30,
        exclude_times: exclude_times
        ).pluck(:time)
        @slots.reject!{ |slot| Time.parse(slot) < current_time }
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=="
        puts @slots
       

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
  end
  