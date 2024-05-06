class AddPatientReferenceToAddress < ActiveRecord::Migration[7.1]
  def change
    add_reference :addresses, :patient, null: false, foreign_key: true
  end
end
