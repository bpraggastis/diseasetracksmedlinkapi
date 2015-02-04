class HomeController < ApplicationController

  def index
    @query = ""
    if params[:condition_query].present?
      @query = params[:condition_query]
      responses = AlternateName.search(@query).records
      @conditions = []
      responses.each do |response|
        response.medical_conditions.each do |condition|
          condition.name = HomeController::hilite(condition.name, @query)
          @conditions << condition
        end
      end



    # if params[:condition_query].present?
    #   @conditions = MedicalCondition.search(params[:condition_query])
    else
      @conditions = MedicalCondition.all
    end
    if params[:therapy_query].present?
      @therapies = MedicalTherapy.search(params[:therapy_query]).records
    else
      @therapies = MedicalTherapy.all
    end
  end


  def self.hilite(string, query = "")
    if query != ""
      string.gsub(query, "<span class='hi-lite'>#{query}</span>").html_safe
    else
      string
    end
  end

end
