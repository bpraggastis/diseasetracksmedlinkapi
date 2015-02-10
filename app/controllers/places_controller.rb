class PlacesController < ApplicationController

  def index
    @marker = Geo.all
    @center = Geo.last
    @latitude = @center.latitude
    @longitude = @center.longitude

  end

end
