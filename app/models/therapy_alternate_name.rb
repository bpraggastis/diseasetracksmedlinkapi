class TherapyAlternateName < ActiveRecord::Base
  include Searchable

  has_many :therapy_synonyms
  has_many :medical_therapies, through: :therapy_synonyms

end
