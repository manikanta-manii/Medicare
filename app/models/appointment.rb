class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :slot_time, presence: true
  enum status: { scheduled: 'scheduled', completed:'completed',closed: 'closed'}
end
