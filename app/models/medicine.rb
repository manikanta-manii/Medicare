class Medicine < ApplicationRecord
    has_many  :cart_items,dependent: :destroy
    validates :name, :description, :dosage, :price,  presence: true
    validates :price, numericality: { greater_than: 0 }
end
