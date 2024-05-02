class Medicine < ApplicationRecord
   
    validates :name, :description, :dosage, :price,  presence: true
    validates :price, numericality: { greater_than: 0 }
end
