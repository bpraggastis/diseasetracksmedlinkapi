class MedicalCondition < ActiveRecord::Base
  #join tables for medical therapies
  has_one :primary_prevention
  has_many :possible_treatments

  #medical therapy associations
  has_many :treaments, classname: "MedicalTherapy", through: :possible_treatments
  has_one :prevention, classname: "MedicalTherapy", through: :primary_prevention

  #medical code associations
  has_many :medical_condition_medical_codes
  has_many :medical_codes, through: :medical_condition_medical_codes

  #medical cause associations
  has_many :medical_condition_medical_causes
  has_many :medical_causes, through: :medical_condition_medical_causes

end
