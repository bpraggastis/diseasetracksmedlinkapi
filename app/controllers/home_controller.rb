class HomeController < ApplicationController

  def index
    @conditions = MedicalCondition.all
  end
end
