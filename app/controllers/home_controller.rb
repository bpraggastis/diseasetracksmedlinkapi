class HomeController < ApplicationController

  def index
    @outbreaks = Outbreak.all
    @events = Event.where(
          date: DateTime.parse('Jan. 15, 2000') .. DateTime.parse('Jan. 15, 2010')
          ).to_a.sort_by{|event| event.date}.reverse[0,100]

  end

  def query
    @outbreak_id = params[:outbreak_id]
    @events = Event.where(outbreak_id: @outbreak_id).to_a.sort_by{|event| event.date}.reverse[0,100]
    render 'home/index'
  end

    # @cquery = ""
    # if params[:condition_query].present?
    #   @cquery = params[:condition_query]
    # end




  def query1
      @cquery = ""
      @tquery = ""
      if params[:condition_query].present?
        @cquery = params[:condition_query]
        responses = AlternateName.search(@cquery).records
        @conditions = []
        responses.each do |response|
          response.medical_conditions.each do |condition|
            @conditions << condition
          end
        end
      else
        @conditions = MedicalCondition.all
      end
      if params[:therapy_query].present?
        @tquery = params[:therapy_query]
        @therapies = MedicalTherapy.search(@tquery).records
      else
        @therapies = []
      end
  end


  def self.hilite(string, query = "")
    if string != nil
      if query != ""
        string.gsub(/#{Regexp.escape query}/i, "<span class='hi-lite'>#{query}</span>").html_safe
      else
        string
      end
    end
  end

end
