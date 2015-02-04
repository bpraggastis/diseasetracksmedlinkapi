class CreateMedicalCodeTherapies < ActiveRecord::Migration
  def change
    create_table :medical_code_therapies do |t|
      t.integer :medical_therapy_id
      t.integer :medical_code_id

      t.timestamps
    end
  end
end
