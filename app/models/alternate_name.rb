class AlternateName < ActiveRecord::Base
  has_one :synonym
  has_many :medical_conditions, through: :synonyms  
end
