class MedicalCause < ActiveRecord::Base
  has_many :medical_causes_conditions
  has_many :medical_conditions, through: :medical_causes_conditions
end
