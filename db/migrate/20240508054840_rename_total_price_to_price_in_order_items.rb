class RenameTotalPriceToPriceInOrderItems < ActiveRecord::Migration[7.1]
  def change
     rename_column :order_items, :total_price, :price
  end
 end