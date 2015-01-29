class CreateMedicalCodeConditions < ActiveRecord::Migration
  def change
    create_table :medical_code_conditions, id: false do |t|
      t.integer :medical_code_id
      t.integer :medical_condition_id
      t.timestamps
    end
  end
end
