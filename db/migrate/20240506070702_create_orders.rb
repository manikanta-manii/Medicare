class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :patient, null: false, foreign_key: true
      t.integer :delivery_address
      t.integer :total_price

      t.timestamps
    end
  end
end
