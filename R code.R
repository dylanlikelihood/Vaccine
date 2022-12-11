# Open data frame
View(symptomtriggers)

# Removed psid by assining it to NULL ( first ID column). 
# Was told it is not needed.
symptomtriggers$psid <- NULL

# create sub data frame called fatigue. 
# the data.frame function: 
fatigue <- data.frame(symptomtriggers$psid, symptomtriggers$psid2,symptomtriggers$opensxtrig_fatigue)

# Open fatigue data frame
View(fatigue)

# Creates a column called fatigue_symptoms
fatigue['symptom_fatigue'] <- NA

# The grep() function: grep() returns the indices in which a match of a string
# appears. Note grep() returns the index, but if you want a simple "is this in 
# here"-or-"is it not", use grepl() instead grep() returns numeric values, 
# whereas grepl() returns a Boolean TRUE/FALSE.
# Searching through the column for the word "peroid", returns 1 if it exists
# in the column.
fatigue$symptom_fatigue[grep("period", fatigue$symptomtriggers.opensxtrig_fatigue)]<- 1