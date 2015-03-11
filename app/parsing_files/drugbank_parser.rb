###########################################################################
#
#      Parser for Drugbank Data.
#
###########################################################################

require 'open-uri'
require 'nokogiri'

DRUG_DATA = Nokogiri::XML(File.open('/Users/prag717/Documents/mld/data-drugbank/drugbank.xml'));puts

drugs = DRUG_DATA.css('/drugbank/drug')

drugs.each do |drug|
  print "."
  name = drug.css("/name").text
  description = drug.css('/description').text
  drugbank_id = drug.css('/drugbank-id[primary="true"]').text
  groups = drug.css('/groups/group').text            ############ this could have multiple entries
  general_reference = drug.css('/general-references').text
  synthesis-reference = drug.css('/synthesis-reference').text
  indication = drug.css('/indication').text
  pharmacodynamics = drug.css('/pharmacodynamics').text
  mechanism-of-action = drug.css('/mechanism-of-action').text
  toxicity = drug.css('/toxicity').text
  metabolism = drug.css('/metabolism').text
  absorption = drug.css('/absorption').text
  half-life = drug.css('/half-life').text
  protein-binding = drug.css('/protein-binding').text
  route-of-elimination = drug.css('/route-of-elimination').text
  volume-of-distribution = drug.css('volume-of-distribution').text
  clearance = drug.css('/clearance').text
  # classification => description, direct-parent, kingdom, superclass, class, subclass
  # salts = drug.css('/salts').text
  synonyms = drug.css('/synonyms/synonym').text ####### this could have multiple entries
  products = drug.css('/products').text
  international-brands = drug.css('/international-brands/international-brand').text ##### this could have multiple entries
  mixtures = drug.css('/mixtures').text
  # packagers => packager/name packager/url
  manufacturer


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
