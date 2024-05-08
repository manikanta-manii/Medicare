class Order < ApplicationRecord
  has_one_attached :prescription
  has_many :order_items ,dependent: :destroy
  has_many :medicines , through: :order_items
  belongs_to :patient
end
