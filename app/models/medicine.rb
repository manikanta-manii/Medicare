class Medicine < ApplicationRecord
    has_one_attached :image
    validates :name, :description, :dosage, :price,  presence: true
    validates :price, numericality: { greater_than: 0 }
end
