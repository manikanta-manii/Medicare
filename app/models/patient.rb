class Patient < ApplicationRecord
  
  validates :gender, presence: { message: "Gender must be selected" }
  validates :dob, presence: true
  validate :dob_in_past
  validates :blood_type , presence: { message: "Blood_type must be selected" }
  enum gender: { male: 'male', female: 'female'}
  enum blood_type: { 'A+': 'A+', 'A-': 'A-', 'B+': 'B+', 'B-': 'B-', 'AB+': 'AB+', 'AB-': 'AB-', 'O+': 'O+', 'O-': 'O-' }

  belongs_to :user,inverse_of: :patient
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  has_many :addresses ,dependent: :destroy
  
  has_many :orders,dependent: :destroy

  private

  def dob_in_past
    if dob.present? && dob.future?
      errors.add(:dob, "can't be in the future")
    end
  end
end
