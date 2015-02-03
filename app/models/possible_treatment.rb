class PossibleTreatment < ActiveRecord::Base

  include Searchable

  belongs_to :medical_therapy
  belongs_to :medical_condition
  # validates :medical_condition, :medical_therapy, presence: true
end
