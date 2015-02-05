class MedicalTherapy < ActiveRecord::Base

  include Searchable

  #join tables back to medical conditions (for treatment and prevention)
  has_many :possible_treatments
  has_many :primary_preventions

  #join tables back to medical conditions (for side-effects and complications)


  #join tables to medical codes
  has_many :medical_code_therapies
  has_many :codes, source: :medical_code, through: :medical_code_therapies

  # Associations back to medical conditions
    #conditions that the treatment prevents:
  has_many :preventable_conditions, class_name: "MedicalCondition", through: :primary_preventions
    #conditions that the treatment treats:
  has_many :treatable_conditions, class_name: "MedicalCondition", through: :possible_treatments

  validate :name, as: :unique

end
