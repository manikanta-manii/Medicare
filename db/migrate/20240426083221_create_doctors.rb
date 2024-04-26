class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.integer :total_rating, default: 0
      t.integer :number_of_ratings, default: 0
      t.integer :rating, default: 0
      t.integer :years_of_experiance
      t.integer :consultation_fee
      t.references :user, null: false, foreign_key: true
      t.references :specialization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
