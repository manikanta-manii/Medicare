class Medicine < ApplicationRecord
    has_many  :cart_items,dependent: :destroy
    
    validates :name, :description, :dosage, :price,  presence: true
    validates :price, numericality: { greater_than: 0 }
     
    has_many  :order_items,dependent: :destroy
    has_many :orders , through: :order_items
    has_one_attached :image
end
