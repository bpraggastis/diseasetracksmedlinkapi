class MedicalCodeCondition < ActiveRecord::Base

  include Searchable

  belongs_to :medical_condition
  belongs_to :medical_code

end
