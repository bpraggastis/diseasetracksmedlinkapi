class CreateMedicalConditionMedicalCauses < ActiveRecord::Migration
  def change
    create_table :medical_condition_medical_causes do |t|
      t.integer :medical_condition_id
      t.integer :medical_cause_id

      t.timestamps
    end
  end
end
