class MedicalCodeTherapy < ActiveRecord::Base
  include Searchable

  belongs_to :medical_therapy
  belongs_to :medical_code


end
