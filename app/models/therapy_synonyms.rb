class TherapySynonym < ActiveRecord::Base

  include Searchable

  belongs_to :alternate_therapy_name
  belongs_to :medical_therapy
end
