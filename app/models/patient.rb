class Patient < ApplicationRecord
  belongs_to :user,inverse_of: :patient
  validates :gender , presence: true
  validates :age , presence: true
  validates :blood_type , presence: true
  enum gender: { male: 'male', female: 'female'}
  enum blood_type: { 'A+': 'A+', 'A-': 'A-', 'B+': 'B+', 'B-': 'B-', 'AB+': 'AB+', 'AB-': 'AB-', 'O+': 'O+', 'O-': 'O-' }
end
