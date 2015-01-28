class MedicalTherapy < ActiveRecord::Base
  has_many :possible_treatments
  has_many :primary_preventions
end
