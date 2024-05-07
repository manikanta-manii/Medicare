class Feedback < ApplicationRecord
  validates :review, presence: true
  validates :rating, presence: true
  belongs_to :appointment

  after_save :update_doctor_rating

  private

  def update_doctor_rating
    doctor = appointment.doctor
    doctor.update(
      total_rating: doctor.total_rating + rating,
      number_of_ratings: doctor.number_of_ratings + 1,
      rating: (doctor.total_rating + rating) / (doctor.number_of_ratings + 1)
    )
  end

end
