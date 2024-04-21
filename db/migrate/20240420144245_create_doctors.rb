class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.integer :total_rating
      t.integer :reviews_count
      t.integer :rating
      t.integer :experience_years
      t.integer :consultation_fee
      t.references :specialization, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
