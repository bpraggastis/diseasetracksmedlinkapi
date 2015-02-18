class MedicalConditionOutbreak < ActiveRecord::Base

  belongs_to :medical_condition
  belongs_to :outbreak
end
