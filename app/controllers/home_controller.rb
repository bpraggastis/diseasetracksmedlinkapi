class HomeController < ApplicationController

  def index

    if params[:condition_query].present?

      @conditions = MedicalCondition.search(params[:condition_query]).records
    else
      @conditions = MedicalCondition.all
    end
    if params[:therapy_query].present?
      @therapies = MedicalTherapy.search(params[:therapy_query]).records
    else
      @therapies = MedicalTherapy.all
    end
  end

end
