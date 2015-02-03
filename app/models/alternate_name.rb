class AlternateName < ActiveRecord::Base

  include Searchable
  
  has_many :synonyms
  has_many :medical_conditions, through: :synonyms
end
