class Cart < ApplicationRecord
  belongs_to :patient
  has_many :cart_items,dependent: :destroy
end
