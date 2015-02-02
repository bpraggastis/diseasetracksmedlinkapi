class AlternateName < ActiveRecord::Base
  has_many :synonyms
  has_many :medical_conditions, through: :synonyms
end
