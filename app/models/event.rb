class Event < ActiveRecord::Base


  #place associations
  has_many :event_places
  has_many :places, through: :event_places

  #medical condition associations
  has_one :outbreak
  has_many :medical_conditions, through: :outbreaks


end
