class Outbreak < ActiveRecord::Base

  # an outbreak is defined as a collection of events with
  # a common concern: mosquito born, under-vaccination, ebola

  has_many :events
  has_many :medical_condition_outbreaks
  has_many :medical_conditions, through: :medical_condition_outbreaks

  has_many :outbreak_places
  has_many :places, through: :outbreak_places

end
