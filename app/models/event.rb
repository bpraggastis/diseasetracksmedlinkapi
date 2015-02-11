class Event < ActiveRecord::Base


  #place associations

  has_many :places, through: :geos

  #medical condition associations
  has_one :outbreak
  has_one :medical_condition
  has_one :geo


end
