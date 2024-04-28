class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.string :status, default: 'scheduled'
      t.string :slot_time

      t.timestamps
    end
  end
end
