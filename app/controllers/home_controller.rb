class HomeController < ApplicationController

  def index
    @conditions = MedicalCondition.all
    @therapies = MedicalTherapy.all
  end
end
