class Synonym < ActiveRecord::Base

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :medical_condition
  belongs_to :alternate_name
  # validates :medical_condition, :alternate_name, presence: true
end
