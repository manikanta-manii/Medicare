class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :slot_time, presence: true
  enum status: { active: 'active', closed: 'closed'}
end
