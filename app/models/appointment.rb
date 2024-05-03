class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  validates :slot_time, presence: true
  validates :reason, presence: true
  has_one :feedback , dependent: :destroy
  enum status: { scheduled: 'scheduled', completed:'completed',canceled: 'canceled'}
end
