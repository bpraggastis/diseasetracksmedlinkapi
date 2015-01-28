class MedicalCause < ActiveRecord::Base
  has_many :medical_condition_medical_causes
  has_many :medical_condition, through: :medical_condition_medical_causes
end
