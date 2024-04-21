class Doctor < ApplicationRecord
  belongs_to :specialization
  belongs_to :user,inverse_of: :doctor

  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments
end
