class Geo < ActiveRecord::Base
  # these are specific places given by latitude and longitude

  has_many :geo_places
  has_many :places, through: :geo_places

end
