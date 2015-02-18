class Event < ActiveRecord::Base


  #place associations

  has_one :place, through: :geos

  #medical condition associations
  belongs_to :outbreak
  belongs_to :medical_condition
  belongs_to :geo

  def latitude
    geo.latitude
  end

  def longitude
    geo.longitude
  end

  def disease
    medical_condition.name
  end

  def location
    geo.name
  end

  def state
    geo.place.abbreviation
  end


end
