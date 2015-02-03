class MedicalCause < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :medical_cause_conditions
  has_many :medical_conditions, through: :medical_cause_conditions
end
