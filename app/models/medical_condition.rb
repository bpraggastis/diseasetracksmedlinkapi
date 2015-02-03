class MedicalCondition < ActiveRecord::Base

  include Searchable

  #join tables for medical therapies
  has_one :primary_prevention
  has_many :possible_treatments

  #medical therapy associations
  has_many :treaments, source: :medical_therapy, through: :possible_treatments
  has_one :prevention, source: :medical_therapy, through: :primary_prevention

  #medical code associations
  has_many :medical_code_conditions
  has_many :codes, source: :medical_code, through: :medical_code_conditions

  #medical cause associations
  has_many :medical_cause_conditions
  has_many :causes, source: :medical_cause, through: :medical_cause_conditions

  #alternate name associations
  has_many :synonyms
  has_many :alternate_names, through: :synonyms



end
