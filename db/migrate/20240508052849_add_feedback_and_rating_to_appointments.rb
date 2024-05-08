class AddFeedbackAndRatingToAppointments < ActiveRecord::Migration[7.1]
  def change
     add_column :appointments, :feedback, :text
     add_column :appointments, :rating, :integer
  end
 end