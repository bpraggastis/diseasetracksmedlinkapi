class CreatePossibleTreatments < ActiveRecord::Migration
  def change
    create_table :possible_treatments do |t|
      t.integer :medical_condition_id
      t.integer :medical_therapy_id

      t.timestamps
    end
  end
end
