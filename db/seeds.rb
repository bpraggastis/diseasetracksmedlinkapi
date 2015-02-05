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
  # taken from rdfs:label
    disease["alternate_names"].each do |alternate_name|
      new_disease.alternate_names.create(name: alternate_name)
    end
  # Faker data used for causes
  rand(3).times do
    new_disease.causes.create(name: Faker::Lorem.word, description: Faker::Company.catch_phrase)
  end

  disease["codes"].each do |code|
    new_disease.codes.create(code_system: code["system"], code_value: code["value"])
  end
end

DRUG_DATA = Nokogiri::XML(File.read('db/support/drugbank.xml'))
drugs = DRUG_DATA.css('/drugbank/drug')
puts drugs.length
n=0
drugs.each do |drug|
  name = drug.css("/name").text
  puts drugs.length - n
  n += 1
  description = drug.css('/description').text
  d = MedicalTherapy.create(name: name, description: description)
  d.codes.create(code_value: drug.css('cas-number').text, code_system: "cas-number")
  d.codes.create(code_system: 'DrugBank', code_value: drug.css('/drugbank-id').first.text)
  codes = drug.css('/external-identifiers/external-identifier')
  codes.each do |code|
    d.codes.create(code_system: code.css('/resource').text, code_value: code.css('identifier').text)
  end
end
