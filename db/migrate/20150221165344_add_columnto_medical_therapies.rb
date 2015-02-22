class AddColumntoMedicalTherapies < ActiveRecord::Migration
  def change
    add_column :medical_therapies, :indications, :text
  end
end
