class CreateMedicalConditionMedicalCodes < ActiveRecord::Migration
  def change
    create_table :medical_condition_medical_codes do |t|
      t.integer :medical_condition_id
      t.integer :medical_code_id

      t.timestamps
    end
  end
end
