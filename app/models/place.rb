class Place < ActiveRecord::Base

# a place is a geographical region
# which may have many geo markers

  # a place will be connected to an event through this join
  has_many :event_places
  has_many :events, through: :event_places

  # a place will be connected to fixed geographical positions
  # through this join
  has_many :place_geos
  has_many :geos, through: :place_geos

end
