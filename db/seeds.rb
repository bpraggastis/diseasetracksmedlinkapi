# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)




###################################################################
###  specific to JSON filefeed as in:
### /Users/brendapraggastis/Ada/capstone/datafiles/samplefile2.json

# def condition_name(item)
#   /#(.*)\sa\sschema:MedicalCondition/.match(item["rdf_id"])[1]
# end
#
# def condition_code_system(code_item)
#   /schema:codeSystem\s*(\w*)/.match(code_item["db"])[1]
# end
#
# def condition_code_value(code_item)
#   /\"(.*)\"/.match(code_item["value"])[1]
# end
#
# def parse_condition(item)
#   name = condition_name(item)
#   codes = []
#   item["code"].each do |code_item|
#     code = {"system"=> condition_code_system(code_item), "value"=> condition_code_value(code_item)}
#     codes << code
#   end
#   return {"name"=> name, "codes" => codes}
# end
#
# def make_disease_bank(array_of_diseases)
#   diseases = []
#   array_of_diseases.each do |disease|
#     condition = parse_condition(disease)
#     diseases << condition
#   end
#   diseases
# end

#################### end of JSON helpers #######################


DISEASE_DATA = JSON.parse(File.read('db/support/disease_file_short.json'))['diseases']
diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)

diseases.each do |disease|
  new_disease = MedicalCondition.create(name: disease["name"])
  disease["codes"].each do |code|
    new_disease.codes.create(code_system: code["system"], code_value: code["value"])
  end
end

DRUG_DATA = Nokogiri::XML(File.open('db/support/drug_data.xml'))
drugs = DRUG_DATA.css('drugbank/drug')
drugs.each do |drug|
  name = drug.css("/name").text
  description = drug.css('/description').text
  MedicalTherapy.create(name: name, description: description)
end
