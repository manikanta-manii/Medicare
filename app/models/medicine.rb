class Medicine < ApplicationRecord
    

    validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

    has_many  :order_items,dependent: :destroy
    has_many :orders , through: :order_items
    has_one_attached :image
end
