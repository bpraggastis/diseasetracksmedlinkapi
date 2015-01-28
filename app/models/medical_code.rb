class MedicalCode < ActiveRecord::Base
  has_one :medical_code_condition
  has_one :medical_condition, through: :medical_codes_conditions
  validates :medical_code_condition, presence: true
end
