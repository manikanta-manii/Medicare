class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.string :street

      t.timestamps
    end
  end
end
