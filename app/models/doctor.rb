class Doctor < ApplicationRecord
  belongs_to :specialization
  belongs_to :user,inverse_of: :doctor
  
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments

  def self.ransackable_associations(auth_object = nil)
    ["appointments", "patients", "specialization", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["consultation_fee", "created_at", "id", "id_value", "number_of_ratings", "rating", "specialization_id", "total_rating", "updated_at", "user_id", "years_of_experiance"]
  end

end
