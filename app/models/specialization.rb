class Specialization < ApplicationRecord
    has_many :doctors, dependent: :destroy
end
