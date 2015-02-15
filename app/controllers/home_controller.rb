class HomeController < ApplicationController

  def index
    @user = User.find(session[:user_id]) if session[:user_id]
    # @outbreaks = Outbreak.all.sort_by{|x| x.title}.collect{|x| x.id}
    # @diseases = MedicalCondition.all.sort_by{|x| x.name}.collect{|x| x.id}

    @outbreaks = find_outbreaks
    @diseases = find_diseases
    @places = find_places
    @start_date = Date.parse('Jan 1, 1979')
    @end_date = Date.parse('Dec. 31, 2014')


    @events = Event.where(
          date: DateTime.parse('Jan. 1, 1979') .. DateTime.now
          ).to_a.sort_by{|event| event.date}.reverse
    # @places = Place.all.sort_by{|x| x.name}.collect{|x| x.id}.uniq
  end

  def query
    @user = User.find(session[:user_id])
    @outbreaks = find_outbreaks(Array(params[:outbreak_id].to_i))
    @diseases = find_diseases(Array(params[:disease_id].to_i))
    @places = find_places(Array(params[:place_id].to_i))
    params[:start_date] == "" ? @start_date = Date.parse('Jan 1, 1979') : @start_date = Date.parse(params[:start_date])
    params[:end_date] == "" ? @end_date = Date.today : @end_date = Date.parse(params[:end_date])
    @events = Event.joins(geo: :place).where({date: @start_date..@end_date,
                                      outbreak_id: @outbreaks,
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


  def sample

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
