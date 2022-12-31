################################################################################
# Author: Dylan Armbruster
# Title: Symptoms for triggers
# Date: 12/16/2022
################################################################################
# Import the symptomtriggers excel file



################################################################################
# Section 1: Setting up the data frames for Fatigue
################################################################################
# niniar packge https://naniar.njtierney.com/ for NA's.



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
Fatigue$trigger_Period[grep("Period|period|Periods|periods|PMS|ovulation|
                            Menstrual",Fatigue$subject_trigger)]<- 1

# Relapse 
Fatigue$trigger_Relapse[grep("Relapse|relapse",
                              Fatigue$subject_trigger)]<- 1

# Physical Activity 
Fatigue$trigger_physicalAcitvity[grep("Exercise|exercise|Activity|
                                      activity|active|Exertion|exertion|chores
                                      |climbing|overexertion|movement|walking" ,
                              Fatigue$subject_trigger)]<- 1
# Fatigue
Fatigue$trigger_Fatigue[grep("Fatigue|fatigue|Fatigued|fatigued" ,
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
Fatigue$trigger_Food[grep("Food|food|histamine|Eating|eating|diet" ,
                                 Fatigue$subject_trigger)]<- 1
# Lack of Sleep
Fatigue$trigger_lackOfSleep[grep("sleep" ,
                          Fatigue$subject_trigger)]<- 1
# Step 8: Remove NA values in the elements of the data frame.
# Fatigue[is.na(Fatigue)] <- ""

################################################################################
## Section 2: Setting up the data frames for Lightheaded
################################################################################


# Step 1: This code creates a sub data frame from symptomstriggers and is
# named Lightheaded
Lightheaded <- data.frame(symptomtriggers$psid2, 
                          symptomtriggers$opensxtrig_lhead)

# Step 2: This code renames column symptomtriggers.psid2 to subjects 
Lightheaded = rename(Lightheaded, subjects = symptomtriggers.psid2)

# Step 3: This code renames column symptomtrigger.opensxtrig_lhead to 
Lightheaded = rename(Lightheaded, subject_triggers = 
                       symptomtrigger.opensxtrig_lhead)

# Step 4: These 3 lines of code creates a column called trigger_Period,
# trigger_Relapse, trigger_physicalAcitvity, trigger_Fatigue,           
# trigger_Cognitive, trigger_Stress, trigger_Temperature, trigger_Food, 
# trigger_lackOfSleep.                                                  
Lightheaded['trigger_Period'] <- NA

Lightheaded['trigger_Relapse'] <- NA

Lightheaded['trigger_physicalAcitvity'] <- NA

Lightheaded['trigger_Fatigue'] <- NA

Lightheaded['trigger_Cognitive'] <- NA

Lightheaded['trigger_Stress'] <- NA

Lightheaded['trigger_Temperature'] <- NA

Lightheaded['trigger_Food'] <- NA

Lightheaded['trigger_lackOfSleep'] <- NA

Lightheaded['trigger_infection'] <- NA


# Step 5: This code searches for strings of symptoms to match to specific coded
# numbers.                                                                     

# Period  
Lightheaded$trigger_Period[grep("Period|period|Periods|periods|PMS|ovulation|
                                Menstrual",Lightheaded$subject_trigger)]<- 1

# Relapse 
Lightheaded$trigger_Relapse[grep("Relapse|relapse",
                                 Lightheaded$subject_trigger)]<- 1

# Physical Activity 
Lightheaded$trigger_physicalAcitvity[grep("Exercise|exercise|Activity|
                                      activity|active|Exertion|exertion|chores
                                      |climbing|overexertion|movement|walking",
                                          Lightheaded$subject_trigger)]<- 1
# Fatigue
Lightheaded$trigger_Fatigue[grep("Fatigue|fatigue|Fatigued|fatigued|Tiredness|
                                 tiredness", Lightheaded$subject_trigger)]<- 1
# Cognitive
Lightheaded$trigger_Cognitive[grep("Cognitive|cognitive" ,
                                   Lightheaded$subject_trigger)]<- 1
# Stress
Lightheaded$trigger_Stress[grep("Stress|stress" ,
                                Lightheaded$subject_trigger)]<- 1
# Temperature
Lightheaded$trigger_Temperature[grep("heat|hot|warm|cold" ,
                                     Lightheaded$subject_trigger)]<- 1
# Food
Lightheaded$trigger_Food[grep("Food|food|histamine|Eating|eating|diet" ,
                              Lightheaded$subject_trigger)]<- 1
# Lack of Sleep
Lightheaded$trigger_lackOfSleep[grep("sleep" ,
                                     Lightheaded$subject_trigger)]<- 1
# Lack of infection
# Note: Subect 192 put "As above" referring to their previous response in 
# fatigue.
Lightheaded$trigger_infection[grep("infection|As above" ,
                                     Lightheaded$subject_trigger)]<- 1

# Step 6: Remove NA values in the elements of the data frame.
# Lightheaded[is.na(Lightheaded)] <- ""

# How to get NA's back
# Lightheaded <- Lightheaded %>%
# dplyr::na_if("")
