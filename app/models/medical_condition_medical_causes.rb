class MedicalConditionMedicalCauses < ActiveRecord::Base
  belongs_to :medical_condition
  belongs_to :medical_cause
end
