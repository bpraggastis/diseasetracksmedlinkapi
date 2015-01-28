class MedicalCode < ActiveRecord::Base
  has_one :medical_condition_medical_code
  has_one :medical_condition, through: :medical_condition_medical_codes
  validates :medical_condition_medical_code, presence: true
end
