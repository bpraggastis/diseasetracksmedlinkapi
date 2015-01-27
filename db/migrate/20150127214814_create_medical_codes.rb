class CreateMedicalCodes < ActiveRecord::Migration
  def change
    create_table :medical_codes do |t|
      t.string :code_value
      t.string :code_system

      t.timestamps
    end
  end
end
