class CreateMedicalCodes < ActiveRecord::Migration
  def change
    create_table :medical_codes do |t|
      t.string :code_system
      t.string :code_value
      t.timestamps
    end
  end
end
