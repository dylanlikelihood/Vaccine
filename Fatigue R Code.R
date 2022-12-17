################################################################################
# Author: Dylan Armbruster
# Title: 
# Date: 12/16/2022
################################################################################




################################################################################
################################################################################
## Section 1: Setting up the data frames
################################################################################
################################################################################

################################################
# Step 1: This code loads in the dplyr package #
################################################
library(dplyr)

##########################################################
# Step 2: This code opens the data frame symptomtriggers #
##########################################################

View(symptomtriggers)

##############################################
# Step 3: This code removes the psid column. #
# Was told it is not needed.                 #
##############################################

symptomtriggers$psid <- NULL

################################################################################
# Step 4: This code creates a sub data frame from symptomstriggers and is
# named Fatigue.
################################################################################

Fatigue <- data.frame(symptomtriggers$psid2, symptomtriggers$opensxtrig_fatigue)

##################################################
# Step 5: This code opens the Fatigue data frame #
##################################################
View(Fatigue)

##########################################################
# Step 6: This code renames column symptomtriggers.psid2 #
##########################################################

Fatigue = rename(Fatigue, subjects = symptomtriggers.psid2)

#######################################################################
# Step 7: This code renames column symptomtriggers.opensxtrig_fatigue #
#######################################################################

Fatigue = rename(Fatigue, subject_symptoms = symptomtriggers.opensxtrig_fatigue)

#############################################################
# Step 8: This code creates a column called fatigue_Period  #
#############################################################

Fatigue['symptom_Period'] <- NA

#############################################################
# Step 9: This code creates a column called fatigue_Relapse #
#############################################################

Fatigue['symptoms_Relapse'] <- NA

#######################################################################
# Step 10: This code creates a column called fatigue_physicalActivity #
#######################################################################

Fatigue['symptoms_physicalAcitvity'] <- NA

##############################################################
# Step 11: This code creates a column called fatigue_Fatigue #
##############################################################

Fatigue['symptoms_Fatigue'] <- NA

###############################################################################
#Step : This code searches for strings of symptoms to match to specific coded #
# numbers.                                                                    #
###############################################################################
# Period  #
Fatigue$symptom_Period[grep("Period|period|Periods|periods|PMS",
                              Fatigue$subject_symptoms)]<- 1

# Relapse #

Fatigue$symptoms_Relapse[grep("Relapse|relapse",
                              Fatigue$subject_symptoms)]<- 1

# Physical Acitvity #
Fatigue$symptoms_physicalAcitvity[grep("Exercise|exercise|Activity|activity" ,
                              Fatigue$subject_symptoms)]<- 1

Fatigue$symptoms_Fatigue[grep("Fatige|fatigue" ,
                                       Fatigue$subject_symptoms)]<- 1



