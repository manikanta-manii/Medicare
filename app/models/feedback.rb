class Feedback < ApplicationRecord
  validates :review, presence: true
  validates :rating, presence: true
  belongs_to :appointment
end
