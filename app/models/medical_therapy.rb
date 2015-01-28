class MedicalTherapy < ActiveRecord::Base
  #join tables back to medical conditions (for treatment and prevention)
  has_many :possible_treatments
  has_many :primary_preventions

  #join tables back to medical conditions (for side-effects and complications)
  

  # Associations back to medical conditions
    #conditions that the treatment prevents:
  has_many :preventable_conditions, classname: "MedicalCondition", through: :primary_preventions
    #conditions that the treatment treats:
  has_many :treatable_conditions, classname: "MedicalCondition", through: :possible_treatments
end
