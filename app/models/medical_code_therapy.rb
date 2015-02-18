class MedicalCodeTherapy < ActiveRecord::Base

  belongs_to :medical_therapy
  belongs_to :medical_code


end
