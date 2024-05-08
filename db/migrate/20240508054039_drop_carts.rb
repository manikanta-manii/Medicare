class DropCarts < ActiveRecord::Migration[7.1]
  def up
     drop_table :carts
  end
 
  def down
     create_table :carts do |t|
       t.references :patient, null: false, foreign_key: true
 
       t.timestamps
     end
  end
 end