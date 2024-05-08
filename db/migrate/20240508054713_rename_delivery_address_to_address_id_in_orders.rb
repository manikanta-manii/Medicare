class RenameDeliveryAddressToAddressIdInOrders < ActiveRecord::Migration[7.1]
  def change
     rename_column :orders, :delivery_address, :address_id
  end
 end