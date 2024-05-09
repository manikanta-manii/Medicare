class ChangeRatingColumnTypeInAppointments < ActiveRecord::Migration[6.0]
  def change
    change_column :appointments, :rating, :float, precision: 2, scale: 1
  end
end