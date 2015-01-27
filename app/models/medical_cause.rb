class MedicalCause < ActiveRecord::Base
  belongs_to :medical_condition_medical_causes
  belongs_to :medical_condition, through: :medical_condition_medical_causes
end
