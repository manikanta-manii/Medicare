class AddTotalPriceToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :total_price, :integer
  end
end
