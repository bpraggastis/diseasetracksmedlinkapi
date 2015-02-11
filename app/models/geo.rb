class Geo < ActiveRecord::Base
  # these are specific places given by latitude and longitude

  has_one :place
  has_many :events

end
