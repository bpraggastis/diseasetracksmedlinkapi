class MedicalCondition < ActiveRecord::Base
  #join tables for medical therapies
  has_one :primary_prevention
  has_many :possible_treatments

  #medical therapy associations
  has_many :treaments, class_name: "MedicalTherapy", through: :possible_treatments
  has_one :prevention, class_name: "MedicalTherapy", through: :primary_prevention

  #medical code associations
  has_many :medical_codes_conditions
  has_many :codes, class_name: "MedicalCode", through: :medical_codes_conditions

  #medical cause associations
  has_many :medical_causes_conditions
  has_many :causes, class_name: "MedicalCause", through: :medical_causes_conditions

end
