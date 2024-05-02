class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :medicine, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity
      t.integer :total_price

      t.timestamps
    end
  end
end
