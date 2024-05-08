class DropFeedbacks < ActiveRecord::Migration[7.1]
  def up
     drop_table :feedbacks
  end
 
  def down
     create_table :feedbacks do |t|
       t.references :appointment, null: false, foreign_key: true
       t.text :review
       t.integer :rating
 
       t.timestamps
     end
  end
 end