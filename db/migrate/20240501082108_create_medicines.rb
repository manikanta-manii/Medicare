class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.string :dosage
      t.integer :price
      t.integer :quantity
      t.boolean :need_prescription

      t.timestamps
    end
  end
end
