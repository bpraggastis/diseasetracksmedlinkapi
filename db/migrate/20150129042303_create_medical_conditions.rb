class CreateMedicalConditions < ActiveRecord::Migration
  def change
    create_table :medical_conditions do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
