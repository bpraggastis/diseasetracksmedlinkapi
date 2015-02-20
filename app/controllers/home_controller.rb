class HomeController < ApplicationController

  def index
    @user = User.find(session[:user_id]) if session[:user_id]
    @outbreaks, @diseases, @places = menu_defaults
    @start_date = Date.parse('Jan 1, 1979')
    @end_date = Date.parse('Dec. 31, 2014')
    @events = Event.includes(:medical_condition, geo: :place).where(
          date: DateTime.parse('Jan. 1, 1979') .. DateTime.now
          ).order(date: :desc)
  end

  def query
    @user = User.find(session[:user_id]) if session[:user_id]
    @outbreaks, @diseases, @places = menu_defaults
    outbreaksq = find_outbreaks(Array(params[:outbreak_id].to_i))
    diseasesq = find_diseases(Array(params[:disease_id].to_i))
    placesq = find_places(Array(params[:place_id].to_i))
    params[:start_date] == "" ? @start_date = Date.parse('Jan 1, 1979') : @start_date = Date.parse(params[:start_date])
    params[:end_date] == "" ? @end_date = Date.today : @end_date = Date.parse(params[:end_date])
    @events = Event.joins(:medical_condition, geo: :place).where({date: @start_date..@end_date,
                                      outbreak_id: outbreaksq,
                                      medical_condition_id: diseasesq,
                                      places: {id: placesq}}
                                      ).order(date: :desc)
    session[:query_id] = params[:commit].to_i if params[:commit].to_i > 0
    render 'home/index'
  end

  def menu_defaults
    outbreaks = []
    diseases = []
    places = []
    temp = Outbreak.includes(:medical_conditions, :places)
    temp.each do |obreak|
      outbreaks << obreak.id
      diseases |= obreak.medical_conditions.collect{|x| x.id}
      places |= obreak.places.collect{|x| x.id} # |= replaces with union - no dupes!
    end
    return outbreaks, diseases, places
  end

  def find_outbreaks(items = [0]) #return ids
    if items - [0] == []
      return Outbreak.all.sort_by{|x| x.title}.collect{|x| x.id}
    else
      return Outbreak.find(items).sort_by{|x| x.title}.collect{|x| x.id}
    end
  end

  def find_diseases(items = [0]) # return ids
    if items - [0] == []
      return MedicalCondition.all.sort_by{|x| x.name}.collect{|x| x.id}
    else
      return MedicalCondition.find(items).sort_by{|x| x.name}.collect{|x| x.id}
    end
  end

  def find_places(items = [0]) # return ids
    if items - [0] == []
      return Place.joins(:outbreaks).uniq.sort_by{|x| x.name}.collect{|x| x.id}
    else
      return Place.find([items]).sort_by{|x| x.name}.collect{|x| x.id}
    end
  end

######################## For Disease Drug Bank ###############################
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
