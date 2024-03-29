# Email me for the csv file: dylanarmbruster15@gmail.com
########################################################

# Load required libraries
library(tidyverse)
library(readr)
library(reshape2)
library(tibble)

# Read the CSV file into a data frame
RawData <- read_csv("symptomtriggers.csv")

# Following The Tidyverse, we make this data frame a tibble.
df <- as_tibble(RawData)

# Inspect The DF
head(df)

# Check for NA's
sum(is.na(df))

# Remove the 'psid' column from RawData
df <- df %>%
  mutate(psid = NULL)

# Rename columns in RawData and assign the modified dataframe to RenamedRawData
Renamed_df <- df %>%
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
FatigueMC <- Renamed_df %>%
  count(Fatigue, sort = TRUE)

# MC Word in LightHeaded
LightHeadedMC <- Renamed_df %>%
  count(LightHeaded, sort = TRUE)

# MC Word in Vertigo
VertigoMC <- Renamed_df %>%
  count(Vertigo, sort = TRUE)
# Pivot the data frame to long form using pivot_longer
df_LongForm <- Renamed_df %>%
  pivot_longer(cols = Fatigue:BowelBladderProblems, values_to = "Responses")  %>%
  rename(Symptom = name)

# Inspect df
head(df_LongForm)

# Select relevant columns: Subject, Symptom, Responses
df_LongForm <- df_LongForm %>%
  select(Subject,Symptom,Responses)


# Inspect df
head(df_LongForm)

# Generate a raw count table for symptoms
# Each key words were decided on by looking through the dataset and thinking about how well the reported words related to the key words. For example, for Physical Activity, I considered reported words that would relate to some sort of movement. Such as climbing or exercise. 
CountsTable <- df_LongForm %>%
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

# Inspect df
head(CountsTable)

# Basic Plots

# Fatigue
ggplot(CountsTable, aes(x = Symptom, y = FatigueCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Fatigue Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Period
ggplot(CountsTable, aes(x = Symptom, y = PeriodCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Periods", x = "Symptom", y = "Period Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))


# Relapse
ggplot(CountsTable, aes(x = Symptom, y = RelapseCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Relapses", x = "Symptom", y = "Relapse Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Physical Activity
ggplot(CountsTable, aes(x = Symptom, y = PhysicalActivityCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Physical Activity", x = "Symptom", y = "Physical Activity Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))


# Stress
ggplot(CountsTable, aes(x = Symptom, y = StressCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Stress", x = "Symptom", y = "Stress Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Temperature
ggplot(CountsTable, aes(x = Symptom, y = TemperatureCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Temperature", x = "Symptom", y = "Temperature Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Food
ggplot(CountsTable, aes(x = Symptom, y = FoodCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Food", x = "Symptom", y = "Food Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Sleep
ggplot(CountsTable, aes(x = Symptom, y = SleepCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Sleep", x = "Symptom", y = "Sleep Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))

# Infections
ggplot(CountsTable, aes(x = Symptom, y = InfectionCount)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(title = "Symptoms Triggered by Infection", x = "Symptom", y = "Infection Frequency") +
  theme(axis.text.x = element_text(size = 9, angle = 70, hjust = 1))


# Most Interesting Plots

# Fatigue
ggplot(CountsTable[CountsTable$FatigueCount != 0, ], 
       aes(x = Symptom, y = as.factor(FatigueCount), fill = Symptom)) +
  geom_bar(stat = "identity") +
  labs(title = "Symptoms Triggered by Fatigue", x = "Symptom", y = "Fatigue Frequency") +
  theme(axis.text.x = element_text(size = 6, angle = 40, hjust = 1), legend.position = "none")


# Period
ggplot(CountsTable[CountsTable$PeriodCount != 0, ], 
       aes(x = Symptom, y = as.factor(PeriodCount), fill = Symptom)) +
  geom_bar(stat = "identity") +
  labs(title = "Symptoms Triggered by Periods", x = "Symptom", y = "Period Frequency") +
  theme(axis.text.x = element_text(size = 6, angle = 40, hjust = 1), legend.position = "none")

# Physical Activity
ggplot(CountsTable[CountsTable$PhysicalActivityCount != 0, ], 
       aes(x = Symptom, y = as.factor(PhysicalActivityCount), fill = Symptom)) +
  geom_bar(stat = "identity") +
  labs(title = "Symptoms Triggered by Physical Activity", x = "Symptom", y = "Physical Activity Frequency") +
  theme(axis.text.x = element_text(size = 6, angle = 40, hjust = 1), legend.position = "none")


# Stress
ggplot(CountsTable[CountsTable$StressCount != 0, ], 
       aes(x = Symptom, y = as.factor(StressCount), fill = Symptom)) +
  geom_bar(stat = "identity") +
  labs(title = "Symptoms Triggered by Stress", x = "Symptom", y = "Stress Frequency") +
  theme(axis.text.x = element_text(size = 6, angle = 40, hjust = 1), legend.position = "none")
