class PlacesController < ApplicationController

  def index
    @place = Place.last
  end

end
