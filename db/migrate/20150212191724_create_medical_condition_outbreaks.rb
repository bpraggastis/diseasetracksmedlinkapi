class CreateMedicalConditionOutbreaks < ActiveRecord::Migration
  def change
    create_table :medical_condition_outbreaks do |t|
      t.integer :medical_condition_id
      t.integer :outbreak_id

      t.timestamps
    end
  end
end
