class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :gender
      t.integer :age
      t.string :blood_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
