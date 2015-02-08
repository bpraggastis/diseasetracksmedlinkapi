class GeoPlace < ActiveRecord::Base
  # join table

  belongs_to :place
  belongs_to :geo

end
