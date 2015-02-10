module MedicalConditionHelpers

###################################################################
###  specific to JSON filefeed as in:
### /Users/brendapraggastis/Ada/capstone/datafiles/samplefile2.json
###################################################################

  class DataSeed

    #primary name of condition take from PNNL database
    def self.condition_name(item)
      /#(.*)\sa\sschema:MedicalCondition/.match(item["rdf_id"])[1].gsub('_',' ').gsub("%27", "'")
    end

    #additional names

    def self.condition_alternate_names(item)
      temp_names = [condition_name(item)]
      temp = /rdfs:label\s"(.*)"/.match(item["name"])[1]
      if temp != "Missing Disease Label"
        temp.split('AND').collect {|alt_name| alt_name.strip}.each do |alt_name|
          temp_names << URI.decode(alt_name)
        end
      end
      return temp_names
    end

    # "name": "rdfs:label \"Missing Disease Label\"
    # "rdfs:label \"17-beta-hydroxysteroid dehydrogenase deficiency\"

    def self.condition_code_system(code_item)
      /schema:codeSystem\s*(\w*)/.match(code_item["db"])[1]
    end

    def self.condition_code_value(code_item)
      /\"(.*)\"/.match(code_item["value"])[1]
    end

    def self.parse_condition(item)
      name = condition_name(item)
      codes = []
      item["code"].each do |code_item|
        code = {"system"=> condition_code_system(code_item), "value"=> condition_code_value(code_item)}
        codes << code
      end
      return {"name"=> name, "codes" => codes, "alternate_names" => condition_alternate_names(item)}
    end

    def self.make_disease_bank(array_of_diseases)
      diseases = []
      array_of_diseases.each do |disease|
        condition = parse_condition(disease)
        diseases << condition
      end
      diseases
    end


  end

#################### end of JSON helpers #######################

end
