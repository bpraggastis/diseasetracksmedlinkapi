class MedicalCodeCondition < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  belongs_to :medical_condition
  belongs_to :medical_code
  validates :medical_code, vmedicalcodecondition: true
end
