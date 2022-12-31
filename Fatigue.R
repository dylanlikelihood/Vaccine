################################################################################
# Author: Dylan Armbruster
# Title: Symptoms for triggers
# Date: 12/16/2022
################################################################################

################################################################################
# Start:
################################################################################
# Import the symptomtriggers excel file and load packages, dply, ggplot2


################################################################################
# Notes:
# To remove NA values in the elements of the data frame, use this code:
# Fatigue[is.na(Fatigue)] <- ""

# niniar packge https://naniar.njtierney.com/ for NA's.
# To see NA's on a plot, use gg_miss_var from the niniar package:
# gg_miss_var(df) + ggtilte("")



################################################################################
# Section 1: Setting up the data frames for Fatigue
################################################################################

# Step 1: This code loads in the dplyr package 
library(dplyr)

# Step 2: This code removes the psid column. 
# Was told it is not needed.                 
symptomtriggers$psid <- NULL

# Step 3: This code creates a sub data frame from symptomstriggers and is
# named Fatigue.
Fatigue <- data.frame(symptomtriggers$psid2, symptomtriggers$opensxtrig_fatigue)

# Step 4: This code renames column symptomtriggers.psid2 
Fatigue = rename(Fatigue, subjects = symptomtriggers.psid2)

# Step 5: This code renames column symptomtriggers.opensxtrig_fatigue 
Fatigue = rename(Fatigue, subject_triggers = symptomtriggers.opensxtrig_fatigue)


# Step 6: These 3 lines of code creates a column called trigger_Period,
# trigger_Relapse, trigger_physicalAcitvity, trigger_Fatigue,           
# trigger_Cognitive, trigger_Stress, trigger_Temperature, trigger_Food, 
# trigger_lackOfSleep.                                                  
Fatigue['trigger_Period'] <- NA

Fatigue['trigger_Relapse'] <- NA

Fatigue['trigger_physicalAcitvity'] <- NA

Fatigue['trigger_Fatigue'] <- NA

Fatigue['trigger_Cognitive'] <- NA

Fatigue['trigger_Stress'] <- NA

Fatigue['trigger_Temperature'] <- NA

Fatigue['trigger_Food'] <- NA

Fatigue['trigger_lackOfSleep'] <- NA

# Step 7: This code searches for strings of symptoms to match to specific coded
# numbers.                                                                     

# Period  
Fatigue$trigger_Period[grep("Period|Periods|PMS|ovulation|
                            Menstrual",ignore.case=TRUE,Fatigue$subject_trigger)]<- 1

# Relapse 
Fatigue$trigger_Relapse[grep("Relapse|relapse",
                              Fatigue$subject_trigger)]<- 1

# Physical Activity 
Fatigue$trigger_physicalAcitvity[grep("Exercise|Activity|
                                      active|Exertion|chores
                                      |climbing|overexertion|movement|walking" ,
                                      ignore.case=TRUE, 
                                      Fatigue$subject_trigger)]<- 1
# Fatigue
Fatigue$trigger_Fatigue[grep("Fatigue|Fatigued",
                             ignore.case=TRUE,
                             Fatigue$subject_trigger)]<- 1
# Cognitive
Fatigue$trigger_Cognitive[grep("Cognitive|cognitive" ,
                             Fatigue$subject_trigger)]<- 1
# Stress
Fatigue$trigger_Stress[grep("Stress|stress" ,
                               Fatigue$subject_trigger)]<- 1
# Temperature
Fatigue$trigger_Temperature[grep("heat|hot|warm|cold" ,
                            Fatigue$subject_trigger)]<- 1
# Food
Fatigue$trigger_Food[grep("Food|food|histamine|Eating|diet", 
                          ignore.case=TRUE,
                          Fatigue$subject_trigger)]<- 1
# Lack of Sleep
Fatigue$trigger_lackOfSleep[grep("sleep",
                          Fatigue$subject_trigger)]<- 1