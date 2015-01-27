class MedicalCondition < ActiveRecord::Base
  has_one :primary_prevention
  has_many :possible_treatments
  has_many :medical_condition_medical_codes
  has_many :medical_codes, through: :medical_condition_medical_codes
  has_many :medical_condition_medical_causes
  has_many :medical_causes, through: :medical_condition_medical_causes

end
