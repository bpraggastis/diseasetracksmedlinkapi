class MedicalConditionMedicalCode < ActiveRecord::Base
  belongs_to :medical_condition
  belongs_to :medical_code
  validates :medical_condition, :medical_code, presence: true
end
