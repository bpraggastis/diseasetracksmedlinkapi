class CreateMedicalCause < ActiveRecord::Migration
  def change
    create_table :medical_causes do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
