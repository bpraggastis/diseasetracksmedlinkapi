class Event < ActiveRecord::Base


  #place associations

  has_many :places, through: :geos

  #medical condition associations
  belongs_to :outbreak
  has_one :medical_condition
  has_one :geo

  def latitude
    Geo.find(self.geo_id).latitude
  end

  def longitude
    Geo.find(self.geo_id).longitude
  end

  def disease
    MedicalCondition.find(self.medical_condition_id).name
  end

  def location
    Geo.find(self.geo_id).name
  end

  def state
    Geo.find(self.geo_id).place.abbreviation
  end


end
