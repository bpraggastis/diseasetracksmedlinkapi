class PrimaryPrevention < ActiveRecord::Base

  include Searchable
  
  belongs_to :medical_therapy
  belongs_to :medical_condition
  # validates :medical_therapy, :medical_condition, presence: true
end
