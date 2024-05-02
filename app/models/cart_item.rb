class CartItem < ApplicationRecord
  belongs_to :medicine
  belongs_to :cart
end
