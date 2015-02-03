module MedicalConditionHelpers

###################################################################
###  specific to JSON filefeed as in:
### /Users/brendapraggastis/Ada/capstone/datafiles/samplefile2.json

class DataSeed

  def self.condition_name(item)
    /#(.*)\sa\sschema:MedicalCondition/.match(item["rdf_id"])[1]
  end

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
    return {"name"=> name.gsub('_',' '), "codes" => codes}
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
