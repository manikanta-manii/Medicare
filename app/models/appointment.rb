class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :slot_time, presence: true
  validates :reason, presence: true
  enum status: { scheduled: 'scheduled', completed:'completed',canceled: 'canceled'}
end
