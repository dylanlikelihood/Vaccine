# Load required libraries
library(tidyverse)
library(readr)
library(reshape2)


# Read the CSV file into a data frame
RawData <- read_csv("symptomtriggers.csv")

# Remove the 'psid' column from RawData
RawData <- RawData %>%
  mutate(psid = NULL)

# Rename columns in RawData and assign the modified dataframe to RenamedRawData
RenamedRawData <- RawData %>%
  rename(Subject = psid2 , Fatigue = opensxtrig_fatigue, 
         LightHeaded = opensxtrig_lhead ,
         Vertigo = opensxtrig_vert,
         Cognitive = opensxtrig_cog,
         Tinnitus = opensxtrig_tin,
         Nausea = opensxtrig_naus,
         Weakness = opensxtrig_weak,
         Insomnia = opensxtrig_ins,
         Breathless = opensxtrig_breath,
         ExercisesIntolerance = opensxtrig_exint,
         SkinProblems = opensxtrig_skin,
         WeightLoss = opensxtrig_wtl,
         WeightGain = opensxtrig_wtg,
         PeriodProblems = opensxtrig_per,
         SwollenGlands = opensxtrig_glands,
         HairLoss = opensxtrig_hair,
         NailFoldHaemge = opensxtrig_nailh,
         NailProblems = opensxtrig_nail,
         Paraesthesia = opensxtrig_para,
         Internalvibrations = opensxtrig_vib,
         Pain = opensxtrig_pain,
         Migranes = opensxtrig_migs,
         NervePain = opensxtrig_np,
         Seizures = opensxtrig_seiz,
         Paralysis = opensxtrig_paralysis,
         Brainzaps = opensxtrig_zaps,
         Speech = opensxtrig_speech,
         FineMotorSkills = opensxtrig_fms,
         Myoclonicjerks = opensxtrig_jerks,
         Tremor = opensxtrig_trem,
         Palpitations = opensxtrig_palps,
         Taxhycardia = opensxtrig_tachy,
         Heartpain = opensxtrig_hcpain,
         Chestpressure = opensxtrig_cpress,
         Bloodpressure = opensxtrig_bp,
         Bulginveins = opensxtrig_veins,
         Bruising = opensxtrig_bruis,
         Jointinflammation = opensxtrig_jinfl,
         Cramps = opensxtrig_cramps,
         Spasms = opensxtrig_spasms,
         Twitches = opensxtrig_twitches,
         Vision = opensxtrig_vision,
         Hearing = opensxtrig_hear,
         Taste = opensxtrig_taste,
         Smell = opensxtrig_smell,
         SensorySenbsitivity = opensxtrig_sens,
         GutProblems = opensxtrig_gut,
         FoodSensitivity = opensxtrig_food,
         BowelBladderProblems = opensxtrig_bb,
         Anxiety = opensxtrig_anx,
         Depression = opensxtrig_dep,
         Hallucinations = opensxtrig_hal,
         MoodProblems = opensxtrig_mood)

# This Code searches for the most common(MC) Words in all the columns in the 
# data frame RenamedRawData 
# Note: This doesn't work very well.

# MC Word in Fatigue
FatigueMC <- RenamedRawData %>%
  count(Fatigue, sort = TRUE)

# MC Word in LightHeaded
LightHeadedMC <- RenamedRawData %>%
  count(LightHeaded, sort = TRUE)

# MC Word in Vertigo
VertigoMC <- RenamedRawData %>%
  count(Vertigo, sort = TRUE)

################################################################################


# Pivot the data frame to long form using pivot_longer
RawDataLongForm <- RenamedRawData %>%
  pivot_longer(cols = Fatigue:BowelBladderProblems, values_to = "Responses")  %>%
  rename(Symptom = name)

# Select relevant columns: Subject, Symptom, Responses
RawDataLongForm <- RawDataLongForm %>%
  select(Subject,Symptom,Responses)


# Generate a frequency table for symptoms
FrequencyTable <- RawDataLongForm %>%
  group_by(Symptom) %>%
  summarize(
    FatigueCount = sum(grepl("(Fatigue)|(Fatigued)|(Tiredness)",
                             Responses, ignore.case = TRUE)),
    PeriodCount = sum(grepl("(Period)|(Periods)|(PMS)|(Menstration)|
                            (Ovulation)|(Hormonal)|(Menstral)|(Periode)",
                            Responses, ignore.case = TRUE)),
    RelapseCount = sum(grepl("(Relapse)",
                             Responses, ignore.case = TRUE)),
    PhysicalActivityCount = sum(grepl("(Exercises)|(Activity)|(Active)
                                      |(Exertion)|(Chores)|(Climbing)|
                                      OverExertion)|(Movement)|(Walking)|
                                      (Climbings)|(Standing)",
                                      Responses, ignore.case = TRUE)),
    StressCount = sum(grepl("(Stress)",
                            Responses, ignore.case = TRUE)),
    TemperatureCount = sum(grepl("(Heat)|(Hot)|(Warm)|(Cold)",
                                 Responses, ignore.case = TRUE)),
    FoodCount = sum(grepl("(Food)|(Histamine)|(Eating)|(Diet)",
                          Responses, ignore.case = TRUE)),
    SleepCount = sum(grepl("(Sleep)", Responses, ignore.case = TRUE)),
    InfectionCount = sum(grepl("(Infection)|(As above)",
                               Responses, ignore.case = TRUE)),
  
  ) %>%
  ungroup()


# Plots
## Fatigue
ggplot(FrequencyTable, aes(x = Symptom, y = FatigueCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Fatigue Count") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))
## Period
ggplot(FrequencyTable, aes(x = Symptom, y = PeriodCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Period Count") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))
## Relapse
ggplot(FrequencyTable, aes(x = Symptom, y = RelapseCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Relapse Count") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))
## Physical Activity
ggplot(FrequencyTable, aes(x = Symptom, y = PhysicalActivityCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Physical Activity Count") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))
## Stress
ggplot(FrequencyTable, aes(x = Symptom, y = StressCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Stress Count") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))
