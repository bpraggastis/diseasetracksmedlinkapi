class MedicalCode < ActiveRecord::Base
  belongs_to :medical_condition_medical_codes
  belongs_to :medical_condition, through: :medical_condition_medical_codes
end
