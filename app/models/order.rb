class Order < ApplicationRecord
  has_one_attachment :prescription
  has_many :order_items
  has_many :medicines , through: :order_items
  belongs_to :patient
end
