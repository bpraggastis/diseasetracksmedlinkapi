# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


DISEASE_DATA = JSON.parse(File.read('db/support/disease_file_short.json'))['diseases']
diseases = MedicalConditionHelpers::DataSeed.make_disease_bank(DISEASE_DATA)

diseases.each do |disease|
  new_disease = MedicalCondition.create(name: disease['name'])
  disease.alternate_names.each do |name|
    new_disease.alternate_names.create(name: name)
  end
  rand(3).times do
    new_disease.causes.create(name: Faker::Lorem.word, description: Faker::Company.catch_phrase)
  end
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
