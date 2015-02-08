# http://api.omim.org/api/entry?mimNumber=220100&include=text&format=json

module OmimHelpers

  class Omim

    # code belongs to class MedicalCode

    def self.omim_hash(code)
      response = HTTParty.get("http://api.omim.org/api/entry?mimNumber=#{code["code_value"]}&include=text:description&format=json&apiKey=#{ENV['OMIM_KEY']}")
      puts response.code, code["code_value"]
      if response.code == 200
        return response.parsed_response["omim"]["entryList"][0]["entry"]
      else
        return nil
      end
    end


    # def omim_hash(code)
    #   response = HTTParty.get("http://api.omim.org/api/entry?mimNumber=#{code}&include=text:description&format=json&apiKey=47F11481134016F9E5D4B8307285E3005C68E7E7")
    #   puts response
    #   # if response.parsed_response
    #   #   puts response.parsed_reponse
    #   #   response.parsed_response["omim"]["entryList"][0]["entry"]
    #   # end
    # end

    # def self.name(omimHash)
    #   omimHash["titles"]["preferredTitle"]
    # end
    #
    # def self.alternate_names(omimHash)
    #   #returns an array
    #   x = omimHash["titles"]["alternativeTitles"]
    #   if x
    #     y = x.split(",")
    #   end
    #   return y
    # end

    def self.description(code)
      if Omim::omim_hash(code) != nil
        omimHash = Omim::omim_hash(code)
        if omimHash["textSectionList"]
          return omimHash["textSectionList"][0]["textSection"]["textSectionContent"]
        end
      end
    end

    # def self.create_omim_hash(code)
    #   omimHash = Omim::omim_hash(code)
    #   # return  {
    #   #           "name" => Omim::name(omimHash),
    #   #           "alt_names" => Omim::alternate_names(omimHash),
    #   #           "description" => Omim::description(omimHash)
    #   #         }
    # end


  end

end

#################Sample omim_hash with initial keys still in place
# {"omim": {
# "version": "1.0",
# "entryList": [
# {"entry": {
# "prefix": "#",
# "mimNumber": 608516,
# "status": "live",
# "titles": {
# "preferredTitle": "MAJOR DEPRESSIVE DISORDER; MDD",
# "alternativeTitles": "UNIPOLAR DEPRESSION",
# "includedTitles": "SEASONAL AFFECTIVE DISORDER, INCLUDED; SAD, INCLUDED"
# } ,
# "textSectionList": [
# {"textSection": {
# "textSectionName": "clinicalFeatures",
# "textSectionTitle": "Clinical Features",
# "textSectionContent": "According to the DSM-IV-TR ({1:American Psychiatric Association, 2000}), major depressive disorder is characterized by one or more major depressive episodes without a history of manic, mixed, or hypomanic episodes. A major depressive episode is characterized by at least 2 weeks during which there is a new onset or clear worsening of either depressed mood or loss of interest or pleasure in nearly all activities. Four additional symptoms must also be present including changes in appetite, weight, sleep, and psychomotor activity; decreased energy; feelings of worthlessness or guilt; difficulty thinking, concentrating, or making decisions; or recurrent thoughts of death or suicidal ideation, plans, or attempts. The episode must be accompanied by distress or impairment in social, occupational, or other important areas of functioning.\n\nMajor depressive disorder is commonly recurrent and can be lethal. Up to 15% of individuals with severe major depressive disorder die by suicide. There is a 4-fold increase in death rate of individuals with major depressive disorder over 55 years of age ({1:American Psychiatric Association, 2000})."
# }
