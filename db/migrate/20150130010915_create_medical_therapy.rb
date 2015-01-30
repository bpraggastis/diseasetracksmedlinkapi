class CreateMedicalTherapy < ActiveRecord::Migration
  def change
    create_table :medical_therapies do |t|
      t.string :name
      t.text :description
    end
  end
end