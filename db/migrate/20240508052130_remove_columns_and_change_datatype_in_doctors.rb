class RemoveColumnsAndChangeDatatypeInDoctors < ActiveRecord::Migration[7.1]
  def change
     remove_column :doctors, :total_rating, :integer
     remove_column :doctors, :number_of_ratings, :integer
     change_column :doctors, :rating, :float,scale: 1
  end
 end