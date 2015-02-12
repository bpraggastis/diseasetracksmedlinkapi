class Place < ActiveRecord::Base

# a place is a geographical region
# which may have many geo markers

has_many :geos
has_many :events, through: :geos

end
