class MedicalCode < ActiveRecord::Base

  include Searchable
  has_one :medical_code_therapy
  has_one :medical_code_condition
  has_one :medical_therapy, through: :medical_code_therapies
  has_one :medical_condition, through: :medical_code_conditions
  validates_uniqueness_of :code_value, scope: :code_system
end
