class PlacesController < ApplicationController

  def index
    @marker = Geo.all[0,4]
    @center = Geo.last
    @latitude = @center.latitude
    @longitude = @center.longitude

  end

end
