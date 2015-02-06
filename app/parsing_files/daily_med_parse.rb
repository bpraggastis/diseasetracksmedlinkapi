DAILY_MED = JSON.parse(File.read('db/support/dmedsmall.json'))
DRUGS = DAILY_MED.keys

NAME = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/name"
DB_CODE = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/genericDrug"
GENERIC = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/genericMedicine"
WARNING = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/warning"
DESCRIPTION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/description"
INDICATION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/indication"
CONTRAINDICATION = "http://www4.wiwiss.fu-berlin.de/dailymed/resource/dailymed/contraindication"

DRUGS.each do |drug|
name = DAILY_MED[drug][NAME][0]["value"]
db_code = DAILY_MED[drug][DB_CODE][0]["value"].match(/.*\/(DB\d+)/)[1]
generic = DAILY_MED[drug][GENERIC][0]["value"]
warning = DAILY_MED[drug][WARNING][0]["value"]
description = DAILY_MED[drug][DESCRIPTION][0]["value"]
indications = DAILY_MED[drug][INDICATION][0]["value"]
contraindications = DAILY_MED[drug][CONTRAINDICATION][0]["value"]




# find the drug therapy with the same code or name
#add the generic name to alt names, and fill in anything that
#is missing. Add warning and description as needed.


end

#Get omim disease descriptions
