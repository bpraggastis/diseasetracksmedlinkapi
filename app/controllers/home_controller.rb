class HomeController < ApplicationController

  def index
    @outbreaks = Outbreak.all.collect{|x| x.id}
    @diseases = find_diseases
    @events = Event.where(
          date: DateTime.parse('Jan. 1, 1960') .. DateTime.now
          ).to_a.sort_by{|event| event.date}.reverse

  end

  def query
    basic_diseases = []
    (1..3).each do |n|
      basic_diseases += Outbreak.find(n).medical_conditions.collect{|x| x.id}
    end # this is a list of ids for all outbreak codes
    @outbreakq = [params[:outbreak_id].to_i] #ids for queried outbreaks
    @diseaseq = [params[:disease_id].to_i] #ids for queried diseases
    @outbreakq.include?(0) ? @outbreaks = Outbreak.all.collect{|x| x.id} : @outbreaks = @outbreakq
    @diseaseq.include?(0)? @diseases = find_diseases(@outbreaks) : @diseases = @diseaseq
    @events = Event.where({outbreak_id: @outbreaks, medical_condition_id: @diseases }).sort_by{|event| event.date}.reverse
    render 'home/index'
  end

  def find_diseases(array = [1,2,3]) # return ids
    diseases = []
    array.each{|x| diseases += Outbreak.find(x).medical_conditions.collect{|x| x.id}}
    diseases
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
