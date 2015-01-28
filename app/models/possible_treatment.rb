class PossibleTreatment < ActiveRecord::Base
  belongs_to :medical_therapy
  belongs_to :medical_condition
end
