class MedicalCode < ActiveRecord::Base
  has_many :medical_condition_medical_codes
  has_many :medical_condition, through: :medical_condition_medical_codes
end
