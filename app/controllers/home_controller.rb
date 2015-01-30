class HomeController < ApplicationController

  def index
    @conditions = MedicalCondition.all
  end

  def query
    
  end

end
