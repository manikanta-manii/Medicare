class Doctor < ApplicationRecord
  belongs_to :specialization
  belongs_to :user,inverse_of: :doctor
end
