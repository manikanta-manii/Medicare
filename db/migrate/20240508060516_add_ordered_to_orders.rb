class AddOrderedToOrders < ActiveRecord::Migration[7.1]
  def change
     add_column :orders, :ordered, :boolean, default: false
  end
 end