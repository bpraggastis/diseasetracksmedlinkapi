class HomeController < ApplicationController

  def index
    @user = User.find(session[:user_id]) if session[:user_id]
    # @outbreaks = Outbreak.all.sort_by{|x| x.title}.collect{|x| x.id}
    # @diseases = MedicalCondition.all.sort_by{|x| x.name}.collect{|x| x.id}

    @outbreaks = find_outbreaks
    @diseases = find_diseases
    @places = find_places


    @events = Event.where(
          date: DateTime.parse('Jan. 1, 1960') .. DateTime.now
          ).to_a.sort_by{|event| event.date}.reverse
    # @places = Place.all.sort_by{|x| x.name}.collect{|x| x.id}.uniq
  end

  def query
    # basic_diseases = []
    # (1..3).each do |n|
    #   basic_diseases += Outbreak.find(n).medical_conditions.collect{|x| x.id}
    # end # this is a list of ids for all outbreak codes

    # @outbreakq = [params[:outbreak_id].to_i] #ids for queried outbreaks
    # @diseaseq = [params[:disease_id].to_i] #ids for queried diseases
    # @statesq = [params[:place_id].to_i] #ids for queried states
    #
    # @outbreakq.include?(0) ? @outbreaks = Outbreak.all.collect{|x| x.id} : @outbreaks = @outbreakq
    # @diseaseq.include?(0)? @diseases = find_diseases(@outbreaks) : @diseases = @diseaseq
    # @statesq.include?(0)? @places = find_places(@outbreaks): @places = @statesq

    @outbreaks = find_outbreaks(Array(params[:outbreak_id].to_i))
    @diseases = find_diseases(Array(params[:disease_id].to_i))
    @places = find_places(Array(params[:place_id].to_i))
    @events = Event.joins(geo: :place).where({outbreak_id: @outbreaks,
                                      medical_condition_id: @diseases,
                                      places: {id: @places}}
                                      ).sort_by{|event| event.date}.reverse
                                    
    render 'home/index'
  end

  def find_outbreaks(items = [0])
    if items.include?(0) || items == []
      return Outbreak.all.sort_by{|x| x.title}.collect{|x| x.id}
    else
      return Outbreak.find(items).sort_by{|x| x.title}.collect{|x| x.id}
    end
  end

  def find_diseases(items = [0]) # return ids
    if items.include?(0) || items == []
      return MedicalCondition.all.sort_by{|x| x.name}.collect{|x| x.id}
    else
      return MedicalCondition.find(items).sort_by{|x| x.name}.collect{|x| x.id}
    end
  end

  def find_places(items = [0]) # return ids
    if items.include?(0) || items == []
      return Place.joins(:outbreaks).uniq.sort_by{|x| x.name}.collect{|x| x.id}
    else
      return Place.find([items]).sort_by{|x| x.name}.collect{|x| x.id}
    end
  end






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
