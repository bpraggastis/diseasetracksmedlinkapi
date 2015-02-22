require 'csv'

#
# ###################################################################################################################
# #
# #          Seed 1: Creates MedicalCondition records by name. Creates associated MedicalCode.
# #
# ###################################################################################################################
#

# ## **********  File Switch  *******************************************************************************************************************************************
diseases_file = open('https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseases.json'){|f| f.read}
DISEASE_DATA = JSON.parse(diseases_file)['diseases']

# DISEASE_DATA = JSON.parse(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseases.json"))['diseases']
# #
#
# ############## Create Initial Seed from list of Outbreak Medical Conditions

mumps = MedicalCondition.create(name: "Mumps", description: "An acute infectious disease caused by RUBULAVIRUS, spread by direct contact, airborne droplet nuclei, fomites contaminated by infectious saliva, and perhaps urine, and usually seen in children under the age of 15, although adults may also be affected. (From Dorland, 28th ed)")
mumps.codes.create(code_system: "meshid", code_value: "D009107")
mumps.codes.create(code_system: "image", code_value: "http://www.cdc.gov/mumps/images/glands_image.gif")
mumps.alternate_names.create(name: "Mumps")
# Adding description and picture to rubella
rubella = MedicalCondition.create(name: "Rubella")
rubella.description = "The incubation period of rubella is 14 days, with a range of 12 to 23 days. Symptoms are often mild, and up to 50% of infections may be subclinical or inapparent. In children, rash is usually the first manifestation and a prodrome is rare. In older children and adults, there is often a 1 to 5 day prodrome with low-grade fever, malaise, lymphadenopathy, and upper respiratory symptoms preceding the rash. The rash of rubella is maculopapular and occurs 14 to 17 days after exposure. The rash usually occurs initially on the face and then progresses from head to foot. It lasts about 3 days and is occasionally pruritic. The rash is fainter than measles rash and does not coalesce. The rash is often more prominent after a hot shower or bath. Lymphadenopathy may begin a week before the rash and last several weeks. Postauricular, posterior cervical, and suboccipital nodes are commonly involved. Arthralgia and arthritis occur so frequently in adults that they are considered by many to be an integral part of the illness rather than a complication. Other symptoms of rubella include conjunctivitis, testalgia, or orchitis. Forschheimer spots may be noted on the soft palate but are not diagnostic for rubella."
rubella.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/a/ab/Rubella_virus_TEM_B82-0203_lores.jpg")
rubella.save
rubella.alternate_names.create(name: "Rubella")

# adding description to malaria
malaria = MedicalCondition.create(name: "Malaria")
malaria.description = "Malaria is a mosquito-borne infectious disease of humans and other animals caused by parasitic protozoans (a group of single-celled microorganism) belonging to the genus Plasmodium. Malaria causes symptoms that typically include fever, fatigue, vomiting and headaches. In severe cases it can cause yellow skin, seizures, coma or death. The disease is transmitted by the biting of mosquitos, and the symptoms usually begin ten to fifteen days after being bitten. In those who have not been appropriately treated disease may recur months later. In those who have recently survived an infection, re-infection typically causes milder symptoms. This partial resistance disappears over months to years if there is no ongoing exposure to malaria."
malaria.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/f/f1/Malaria.jpg")
malaria.save
malaria.alternate_names.create(name: "Malaria")

# adding Ebola image and description
ebola = MedicalCondition.create(name: "Ebola")
ebola.description = "Ebola, previously known as Ebola hemorrhagic fever, is a rare and deadly disease caused by infection with one of the Ebola virus strains. Ebola can cause disease in humans and nonhuman primates (monkeys, gorillas, and chimpanzees). Ebola is caused by infection with a virus of the family Filoviridae, genus Ebolavirus. There are five identified Ebola virus species, four of which are known to cause disease in humans: Ebola virus (Zaire ebolavirus); Sudan virus (Sudan ebolavirus); Taï Forest virus (Taï Forest ebolavirus, formerly Côte d’Ivoire ebolavirus); and Bundibugyo virus (Bundibugyo ebolavirus). The fifth, Reston virus (Reston ebolavirus), has caused disease in nonhuman primates, but not in humans."
ebola.codes.create(code_system: "image", code_value: "http://www.utmb.edu/virusimages/images/micrographs/Ebola_virus_2.jpg")
ebola.save
ebola.alternate_names.create(name: "Ebola")

# adding Encephalitis
encephalitis = MedicalCondition.create(name: "Encephalitis, St. Louis", description: "St. Louis encephalitis (SLE) is a viral infection of the brain (encephalitis) that is spread to humans through the bite of infected mosquitoes. Although the virus does not always cause disease, when it does, it can be life-threatening. The SLE virus is part of a group of viruses that are transmitted by blood-sucking insects, such as mosquitoes (arboviruses). Birds, especially domestic fowl, can harbor the virus. As the population of infected birds increase, outbreaks of SLE occur. This disease was first identified in St. Louis, hence the name.")
encephalitis.codes.create(code_system: "image", code_value: "http://upload.wikimedia.org/wikipedia/commons/8/8c/St._Louis_Encephalitis_%28SLE%29_virus_EM_PHIL_1871_lores.JPG")
encephalitis.alternate_names.create(name: "Encephalitis, St. Louis")
# West Nile virus
w = MedicalCondition.create(name: "West Nile Virus")
w.description = "West Nile virus (WNV) is a mosquito-borne zoonotic arbovirus belonging to the genus Flavivirus in the family Flaviviridae. This flavivirus is found in temperate and tropical regions of the world. It was first identified in the West Nile subregion in the East African nation of Uganda in 1937. The main mode of WNV transmission is via various species of mosquitoes, which are the prime vector, with birds being the most commonly infected animal and serving as the prime reservoir host—especially passerines, which are of the largest order of birds, Passeriformes."
w.save
w.codes.create(code_system: "image", code_value: "http://media.worldbulletin.net/250x190/2012/08/30/west-nile-virus.jpg")
w.alternate_names.create(name: "West Nile Virus")


diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)

diseases.each do |disease|
  print "."
  new_disease = MedicalCondition.find_by(name: disease['name']) || MedicalCondition.create(name: disease['name'])
  disease["alternate_names"].each do |alternate_name|
    unless new_disease.alternate_names.collect{|x| x.name}.include?(alternate_name)
      new_disease.alternate_names.create(name: alternate_name)
    end
  end
  disease["codes"].each do |code|
    begin
      new_disease.codes.create(code_system: code["system"], code_value: code["value"])
    rescue
      print "!"
      next
    end
  end

end
puts "Seed 1 complete"

#
# ###################################################################################################################
# #
# #          Seed 2: Creates MedicalTherapy by name, description. Creates associated MedicalCode.
# #
# ###################################################################################################################
#

# **********  File Switch  *******************************************************************************************************************************************
drugbank_file = open('https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/drugbank.xml'){|f| f.read}
DRUG_DATA = Nokogiri::XML(drugbank_file)
# # puts "loading drugbank file"
# # DRUG_DATA = Nokogiri::XML(HTTParty.get("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/drugbank.xml"))
# puts "got past defining drug_data"
drugs = DRUG_DATA.css('/drugbank/drug')

# puts drugs.length
# n=0
drugs.each do |drug|
  print "."
  name = drug.css("/name").text
#   puts drugs.length - n
#   n += 1

  description = drug.css('/description').text
  begin
    d = MedicalTherapy.create(name: name, description: description)
    d.codes.create(code_value: drug.css('cas-number').text, code_system: "cas-number")
    d.codes.create(code_system: 'DrugBank', code_value: drug.css('/drugbank-id').first.text)
    codes = drug.css('/external-identifiers/external-identifier')
    codes.each do |code|
      d.codes.create(code_system: code.css('/resource').text, code_value: code.css('identifier').text)
    end
  rescue
    print "!"
    next
  end
end
puts "Seed 2 complete"

###################################################################################################################
#
#          Seed 3: Adds MedicalTherapy by name. Creates associated MedicalCode for DrugBank and DailyMed.
#                  Included generic name as associated AlternateName.
#
###################################################################################################################

# # **********  File Switch  *******************************************************************************************************************************************
# DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed(File.read("/Users/brendapraggastis/Ada/capstone/datafiles/dailymed_dump.json"))
dmed_file = open('https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/dailymed_dump.json'){|f| f.read}
DMED = MedicalTherapyHelpers::DailyMedSeed::make_daily_med_seed(dmed_file)
#
# This returns {dmedcode => {name:----, db_code:----, generic:----, description:----},--=>{..}...}
# Check medical_therapy_helpers for additional fields

DMED.keys.each do |dkey|  #dkey = primary key for DailyMed record
  print "*"
  dKey = DMED[dkey] #dKey = the hash for the drug in dailymed record dkey
  if dKey[:db_code] != nil
    therapy_code = MedicalCode.find_by(code_system: "DrugBank", code_value: dKey[:db_code])
    if therapy_code != nil
      therapy = therapy_code.medical_code_therapies[0].medical_therapy
    end
  end
  if therapy != nil
    begin
      therapy.codes.create(code_system: "DailyMed", code_value: dkey )
    rescue
      print " !!dmed not created !! "+ dkey
      next
    end
    # dmed_code = therapy.codes.find_by(code_system: "DailyMed", code_value: dkey)
    begin
      therapy.therapy_alternate_names.create(name: dKey[:generic])
    rescue
      print " !!alt_names_failure!! "
      next
    end
  else
    begin
      therapy = MedicalTherapy.create(name: dKey[:name], description: dKey[:description], indications: dKey[:indications])
      therapy.codes.create(code_system: "DailyMed", code_value: dkey)
    rescue
      print "! med therapy & code failure ! "+dkey
      next
    end
    begin
      therapy.therapy_alternate_names.create(name: dKey[:generic][0,255]) if dKey[:generic] != nil
      therapy.codes.create(code_system: "DrugBank", code_value: dKey[:db_code]) if dKey[:db_code] != nil
    rescue
      print "! alt name fails !"
      next
    end

  end

end
puts "Seed 3 Complete"
#
#
# ###################################################################################################################
# #
# #          Seed 4: Adds drug-disease associations to PrimaryPreventions.
# #
# ###################################################################################################################

# # **********  File Switch  *******************************************************************************************************************************************




diseasome_file = open("https://s3-us-west-2.amazonaws.com/capstone-datafiles/datafiles/diseasome_dump.json"){|f| f.read}
l = JSON.parse(diseasome_file)
#
l.keys.each do |key|
  print "."
  name = URI.decode(l[key]['http://schema.org/name'][0]['value']).gsub("_", " ") if l[key]['http://schema.org/name']
  preventions = l[key]["http://schema.org/primaryPrevention"]
  if name && preventions
    diseasealt = AlternateName.find_by(name: name)
    if diseasealt
      disease = diseasealt.medical_conditions[0]
    end
    if disease != nil
      preventions.each do |hash|
        # if nums = hash['value'].match(/http:\/\/beowulf.pnnl.gov\/2014\/drug\/DB\d+/)
        dcode = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(hash['value'])
        db, code = dcode[1], dcode[2]
        if db != nil
          begin
            drug_code = MedicalCode.find_by(
                                  code_system: "DrugBank",
                                  code_value: db + code
                                )
            drug = drug_code.medical_code_therapies[0].medical_therapy if drug_code != nil
          rescue
            puts "!1 "
            next
          end
        else
          begin
            drug_code = MedicalCode.find_by(
                                  code_system: "DailyMed",
                                  code_value: code
                                )
            drug = drug_code.medical_code_therapies[0].medical_therapy if drug_code != nil
          rescue
            puts "!2 "
            next
          end
        end
        if drug != nil
          begin
          PrimaryPrevention.create(
                              medical_therapy_id: drug.id,
                              medical_condition_id: disease.id)
          rescue
            print "!3 "
            next
          end
        else
          # puts '*'*(80)
          # print "drug: ", dcode
          # print "disease: " , disease.name
          # puts '*'*(80)
        end
      end
    end
  end

end


def parse_drug(string)
  drug = /http:\/\/beowulf\.pnnl\.gov\/2014\/drug\/(DB)*(\d*)/.match(string)
  return drug[1], drug[2]
end


print  "Seed 4 complete.."




# #
# # ###################################################################################################################
# # #
# # #          Seed 5: Adds Omim Description to MedicalCondition
# # #
# # ###################################################################################################################
# #
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
#
#
#     end
#   end
# end
