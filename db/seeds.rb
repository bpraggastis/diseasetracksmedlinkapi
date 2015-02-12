require 'csv'
# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# # #
# # # Examples:
# # #
# # #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# # #   Mayor.create(name: 'Emanuel', city: cities.first)
# #
# #
# # ###################################################################################################################
# # #
# # #          Seed 1: Creates MedicalCondition records by name. Creates associated MedicalCode.
# # #
# # ###################################################################################################################
# #
# #
# # DISEASE_DATA = JSON.parse(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/diseases.json"))['diseases']
# # DISEASE_DATA = JSON.parse(File.read("db/support/disease_file.json"))['diseases']
# ######--> Replace with correct path name
#
#
# DISEASE_DATA = JSON.parse(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseases.json"))['diseases']
#
# diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)
#
#
# diseases.each do |disease|
#   new_disease = MedicalCondition.create(name: disease['name'])
#   puts disease["name"]
#   # taken from rdfs:label
#     disease["alternate_names"].each do |alternate_name|
#       new_disease.alternate_names.create(name: alternate_name)
#     end
#   # Faker data used for causes
# # rand(3).times do
# #  new_disease.causes.create(name: Faker::Lorem.word, description: Faker::Company.catch_phrase)
# #end
#
#   disease["codes"].each do |code|
#     new_disease.codes.create(code_system: code["system"], code_value: code["value"])
#   end
# end
# ##### Don't forget to add Mumps!
# mumps = MedicalCondition.create(name: "Mumps", description: "An acute infectious disease caused by RUBULAVIRUS, spread by direct contact, airborne droplet nuclei, fomites contaminated by infectious saliva, and perhaps urine, and usually seen in children under the age of 15, although adults may also be affected. (From Dorland, 28th ed)")
# mumps.codes.create(code_system: "meshid", code_value: "D009107")
#
# #
# #
# #
# # ###################################################################################################################
# # #
# # #          Seed 2: Creates MedicalTherapy by name, description. Creates associated MedicalCode.
# # #
# # ###################################################################################################################
# #
# # DRUG_DATA = Nokogiri::XML(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/drugbank.xml'))
# DRUG_DATA = Nokogiri::XML(File.read('db/support/drugbank.xml'))
# ######--> Replace with correct path name
#
# drugs = DRUG_DATA.css('/drugbank/drug')
#
# puts drugs.length
# n=0
# drugs.each do |drug|
#   name = drug.css("/name").text
#   puts drugs.length - n
#   n += 1
#   description = drug.css('/description').text
#   d = MedicalTherapy.create(name: name, description: description)
#   d.codes.create(code_value: drug.css('cas-number').text, code_system: "cas-number")
#   d.codes.create(code_system: 'DrugBank', code_value: drug.css('/drugbank-id').first.text)
#   codes = drug.css('/external-identifiers/external-identifier')
#   codes.each do |code|
#     d.codes.create(code_system: code.css('/resource').text, code_value: code.css('identifier').text)
#   end
# end
#
#
#
# ###################################################################################################################
# #
# #          Seed 3: Adds MedicalTherapy by name. Creates associated MedicalCode for DrugBank and DailyMed.
# #                  Included generic name as associated AlternateName.
# #
# ###################################################################################################################
# # DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed("/Users/brendapraggastis/Ada/capstone/datafiles/dailymed_dump.json")
DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed("db/support/dailymed_dump.json")
######--> Replace with correct path name
# This returns {dmedcode => {name:----, db_code:----, generic:----, description:----},--=>{..}...}
# Check medical_therapy_helpers for additional fields
#
# DMED.keys.each do |dkey|  #dkey = primary key for DailyMed record
#   dKey = DMED[dkey] #dKey = the hash for the drug in dailymed record dkey
#   therapy = nil
#   therapy_code = MedicalCode.find_by(code_value: dKey[:db_code])
#   if dKey[:db_code] != nil
#     therapy = therapy_code.medical_code_therapy.medical_therapy if therapy_code != nil
#   end
#   if therapy != nil
#     dmed_code = therapy.codes.find_by(code_system: "DailyMed", code_value: dkey)
#     begin
#       therapy.codes.create(code_system: "DailyMed", code_value: dkey) if dmed_code == nil
#     rescue
#       temp_ar = therapy.codes.map {|code| code.code_system == "DailyMed"? code.code_value : next }
#       puts "DailyMed Duplicate Code! Code value: #{dkey}"
#       if temp_ar.include? dkey
#         puts "Code was already in there"
#       else
#         puts temp_ar.inspect
#         puts "They were trying to put in a second DM code."
#       end
#     end
#     therapy.therapy_alternate_names.create(name: dKey[:generic])
#   else
#     therapy = MedicalTherapy.create(name: dKey[:name], description: dKey[:description])
#     puts therapy.name
#     therapy.therapy_alternate_names.create(name: dKey[:generic][0,255]) if dKey[:generic] != nil
#     therapy.codes.create(code_system: "DrugBank", code_value: dKey[:db_code]) if dKey[:db_code] != nil
#     therapy.codes.create(code_system: "DailyMed", code_value: dkey)
#   end
#
# end
#
#
# ###################################################################################################################
# #
# #          Seed 4: Adds drug-disease associations to PrimaryPreventions.
# #
# ###################################################################################################################
# # l = JSON.parse(File.read('/Users/brendapraggastis/Ada/capstone/datafiles/diseasome_dump.json'))
# ######--> Replace with correct path name
# l = JSON.parse(File.read('db/support/diseasome_dump.json'))
#
# l.keys.each do |key|
#   name = URI.decode(l[key]['http://schema.org/name'][0]['value']).gsub("_", " ") if l[key]['http://schema.org/name']
#   preventions = l[key]["http://schema.org/primaryPrevention"]
#   if name && preventions
#     diseasealt = AlternateName.find_by(name: name)
#     if diseasealt
#       disease = diseasealt.medical_conditions[0]
#     end
#     if disease != nil
#       preventions.each do |hash|
#         # if nums = hash['value'].match(/http:\/\/beowulf.pnnl.gov\/2014\/drug\/DB\d+/)
#         dcode = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(hash['value'])
#         db, code = dcode[1], dcode[2]
#         if db != nil
#           begin
#             drug_code = MedicalCode.find_by(
#                                   code_system: "DrugBank",
#                                   code_value: db + code
#                                 )
#             drug = drug_code.medical_code_therapy.medical_therapy if drug_code != nil
#           rescue
#             puts "No connection"
#             next
#           end
#         else
#           begin
#             drug_code = MedicalCode.find_by(
#                                   code_system: "DailyMed",
#                                   code_value: code
#                                 )
#             drug = drug_code.medical_code_therapy.medical_therapy if drug_code != nil
#           rescue
#             puts "No connection"
#             next
#           end
#         end
#         if drug != nil
#           puts PrimaryPrevention.create(
#                               medical_therapy_id: drug.id,
#                               medical_condition_id: disease.id)
#         else
#           puts '*'*(80)
#           print "drug: ", dcode
#           print "disease: " , disease.name
#           puts '*'*(80)
#         end
#       end
#     end
#   end
#
# end
#
#
# def parse_drug(string)
#   drug = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(string)
#   return drug[1], drug[2]
# end
#
#
#
# ###################################################################################################################
# #
# #          Seed 5: Adds Omim Description to MedicalCondition
# #
# ###################################################################################################################
#
# omim_refs = MedicalCode.select{|name| name.code_system == 'omim' && name.code_value.to_i.to_s === name.code_value}
# # omim_refs = [MedicalCode.find_by("code_system" == 'omim' && "code_value" == '242500')]
# omim_refs.each do |code|
#   omim_description = OmimHelpers::Omim::description(code)
#   if omim_description != nil
#     condition = MedicalCode.find_by(
#                           code_system: "omim",
#                           code_value: "#{code["code_value"]}"
#                           ).medical_conditions[0]
#     if condition != nil
#       condition.update(description: omim_description)
#       # puts hash["description"][0,50] if hash["description"]
#       puts condition.name
#
#
#     end
#   end
# end
#
#
#
# ##################################################################################################################
#
#          Seed 6: Place names will be given by name(state/country/territory), and abbreviation
#
# ##################################################################################################################
#
#
# omim_refs = MedicalCode.select{|name| name.code_system == 'omim' && name.code_value.to_i.to_s === name.code_value}
# omim_refs.each do |code|
#   omim_description = OmimHelpers::Omim::description(code)
#   if omim_description != nil
#     condition = MedicalCode.find_by(
#                           code_system: "omim",
#                           code_value: "#{code["code_value"]}"
#                           ).medical_conditions[0]
#     if condition != nil
#       condition.update(description: omim_description)
#       # puts hash["description"][0,50] if hash["description"]
#       puts condition.name
#     end
#   end
# end
#
# ##################################################################################################################
#
#          Seed 6: Location data from CSV files
#
# ##################################################################################################################
#
#
# ############# Convert CSV file to JSON ####################
# def is_int?(string)
#   !!(string =~ /^[+-]?[1-9][0-9]*$/)
# end
# #
# # ####--> Replace with correct path name
# lines = CSV.open('db/support/us_geo_populated_place.csv').readlines
# keys = lines.shift
# n = lines.count
#
# File.open("db/support/us_locations.json", "w") do |f|
#   data = lines.map do |values|
#           puts n
#           n -= 1
#           Hash[keys.zip(values.map{|val| is_int?(val) ? val.to_i : val})]
#           end
#   f.puts JSON.pretty_generate(data)
#   f.close
# end
# #
# #
# # ############## Seed Places Table #############
# lines = CSV.open('db/support/places.csv').readlines
# lines.each do |abbr,region|
#   Place.create(name: region ,abbreviation: abbr)
# end
#
# ############## Seed GEO Table ################
#
#
# #####--> Replace with correct path name

# geo_data = JSON.parse(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/us_locations.json"))
# # geo_data = JSON.parse(File.read('db/support/locations.json'))
# geo_data = JSON.parse(File.read("db/support/us_locations.json"))
# # geo_data = JSON.parse(File.read('db/support/locations.json'))
# geo_data.each do |local|
#   new_geo = Geo.create(
#               name: local["FEATURE_NAME"],
#               latitude: local["PRIM_LAT_DEC"],
#               longitude: local["PRIM_LONG_DEC"],
#               county: local["COUNTY_NAME"],
#               place_id: Place.find_by(abbreviation: local["STATE_ALPHA"] ).id
#               )
#               puts new_geo.name
#
# end
#
#
#
# sample item from locations.json
# {
#   "FEATURE_ID": 1397658,
#   "FEATURE_NAME": "Ester",
#   "FEATURE_CLASS": "Populated Place",
#   "STATE_ALPHA": "AK",
#   "STATE_NUMERIC": 2,
#   "COUNTY_NAME": "Fairbanks North Star",
#   "COUNTY_NUMERIC": 90,
#   "PRIMARY_LAT_DMS": "645050N",
#   "PRIM_LONG_DMS": "1480052W",
#   "PRIM_LAT_DEC": "64.8472222",
#   "PRIM_LONG_DEC": "-148.0144444",
#   "SOURCE_LAT_DMS": null,
#   "SOURCE_LONG_DMS": null,
#   "SOURCE_LAT_DEC": null,
#   "SOURCE_LONG_DEC": null,
#   "ELEV_IN_M": 221,
#   "ELEV_IN_FT": 725,
#   "MAP_NAME": "Fairbanks D-3",
#   "DATE_CREATED": "12/31/95",
#   "DATE_EDITED": "1/24/09"
# },
# ##################################################################################################################
#
#          Seed 7: Outbreaks and Events
#
# ##################################################################################################################
#
# # TO DO:
# # parse the 3 outbreak tables
# # seed Events and associate with Geo and Place in tables.
# # add counties to Geo data
# # add place_id to Geo data

# DISEASE_HASH = {
#   "Rubella" => ["D012409","10018206","N0000002655","36653000","C0035920"],
#   "Ebola" => ["D019142","10014071","N0000003898","37109004","C0282687"],
#   "Malaria" => ["1385","7728","C03.752.250.552","Malaria","248310"],
#   "West Nile virus" => ["C1096184"],
#   "Encephalitis" => ["C0014060"],
#   "Mumps" => ["D009107","10009300","N0000002055","240526004","36989005","C0026780"]
# }


# code_hash = {}
# DISEASE_HASH.each do |key,value|
#   value.each do |val|
#     code_hash[val] = key
#   end
# end

### to enter Events:
#  event_hash.keys = {number_infected, date, disease_code, latitude,
#                     longitude, feature, county, state}
#  medical_condition_id = MedicalCondition.find_by(name: code_hash(disease_code)).id
#  outbreak_id = number given by filename
#  geo_id = Geo.find_by(name: feature).id || Geo.create(.....)
#  we could also use latitude, longitude here for find_by
#  if we need to do a Geo.create then we need to add place_id
#

######## Outbreaks  Seed:##########


# Outbreak.create(title: "Mosquito Born", description: "Cases of Malaria and West " +
# "Nile Virus found in Louisiana, Florida, Georgia, Mississippi, Arkansas, and Alabama.")
# Outbreak.create(title: "Under-vaccination", description: "Cases of Rubella, Mumps, and " +
# "Encephalitis in California, Oregon, and Washington due to lack of vaccination.")
# Outbreak.create(title: "Ebola", description: "Cases of Ebola occuring in New Jersey and New York State.")
#
####### Events Seed: Turn on DISEASE_HASH and code_hash ###########
#
# DISEASE_HASH = {
#   "Rubella" => ["D012409","10018206","N0000002655","36653000","C0035920"],
#   "Ebola" => ["D019142","10014071","N0000003898","37109004","C0282687"],
#   "Malaria" => ["1385","7728","C03.752.250.552","Malaria","248310"],
#   "West Nile virus" => ["C1096184"],
#   "Encephalitis" => ["C0014060"],
#   "Mumps" => ["D009107","10009300","N0000002055","240526004","36989005","C0026780"]
# }
#
# code_hash = {}
# DISEASE_HASH.each do |key,value|
#   value.each do |val|
#     code_hash[val] = key
#   end
# end
#
# (1..3).each do |n|
#   outbreak = JSON.parse(File.read("db/support/outbreak-#{n}.json"))
#   outbreak.each do |event|
#     unless g = Geo.find_by(name: event["location"]["FEATURE_NAME"])
#         pl = Place.find_by(abbreviation: event["location"]["STATE_ALPHA"])
#         g = Geo.create(latitude: event["location"]["PRIM_LAT_DEC"],
#                    longitude: event["location"]["PRIM_LAT_DEC"],
#                    name: event["location"]["FEATURE_NAME"],
#                    county: event["location"]["COUNTY_NAME"],
#                    place_id: pl.id)
#     end
#     event["location"]["DATE_CREATED"]? d = Date.strptime(event["location"]["DATE_CREATED"], "%m/%d/%y") : d = nil
#     begin
#       Outbreak.find(n).events.new(
#           date: d,
#           medical_condition_id: MedicalCondition.find_by(name: code_hash[event["disease"]]).id,
#           number_infected: event["population"].to_i,
#           geo_id: g.id)
#     rescue
#       puts MedicalCondition.find_by(name: code_hash[event["disease"]]).inspect
#       puts event["disease"]
#       puts code_hash[event["disease"]]
#     end
#   end
# end
