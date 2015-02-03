class CreateMedicalCauseCondition < ActiveRecord::Migration
  def change
    create_table :medical_cause_conditions do |t|
      t.integer :medical_cause_id
      t.integer :medical_condition_id
      t.timestamps
    end
  end
end
