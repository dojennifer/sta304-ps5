library(tidyverse)
library(ggplot2)
library(dplyr)


# Load Toronto Public Health Data
COVID19_cases <- read_csv("COVID19 cases.csv")

# Clean Data
COVID19_cases_clean <- COVID19_cases %>% 
  select(Assigned_ID, `Episode Date`, `Reported Date`,`Age Group`,`Client Gender`,`Source of Infection`, `Ever Hospitalized`, `Ever in ICU`, Classification, Outcome)
COVID19_cases_clean2 <- COVID19_cases_clean %>% 
  mutate(Outcome = ifelse (Outcome == "RESOLVED",1,0),
  `Ever Hospitalized` = ifelse (`Ever Hospitalized` == "Yes",1, 0), 
  `Ever in ICU` =ifelse (`Ever in ICU` == "Yes",1 , 0)) %>%   
  filter( `Source of Infection` != "Pending",
          `Source of Infection` != "Unknown/Missing",
          Classification != "Probable")

# Clean and summarize total COVID-19 cases 
totalcases <- COVID19_cases_clean2 %>% 
  group_by(`Reported Date`) %>% 
  summarise(total=n())

#1 Plot Total COVID-19 Cases
totalcovidcases <- ggplot(totalcases, aes(x=`Reported Date`, y=cases)) + 
  geom_line(aes(x=`Reported Date`, y=total)) +
  labs(x = "Reported Date", 
       y = "Number of cases",
       title = "Total COVID-19 Cases in Toronto (Jan 23 - Dec 28, 2020)")
totalcovidcases
ggsave("outputs/figures/totalcovidcases.pdf")

# Summarize source of infection data
summary_sourceofinfection <- COVID19_cases_clean2 %>% 
  group_by(`Source of Infection`) %>% 
  summarise(count=n())

#2 Plot Source of Infection
sourceofinfection <- ggplot(summary_sourceofinfection, aes(x=`Source of Infection`, y=count, fill =`Source of Infection`)) + 
  geom_bar(stat="identity") + 
  theme_minimal()+ theme(legend.position = "none")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  theme(plot.title = element_text(hjust = 0.5)) + 
  labs(x = "Sources of Infection", 
       y = "Number of cases",
       title = "Sources of COVID-19 Infection")
sourceofinfection
ggsave("outputs/figures/sourceofinfection.pdf")


# Preparing Source of Infection Plot Data in frame  
summary_source1 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 1) %>%
  group_by(`Source of Infection`) %>% 
  summarise(count = n())

summary_source1$Resolved <- "1 = YES"

summary_source0 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 0) %>%
  group_by(`Source of Infection`) %>% 
  summarise(count = n())

summary_source0$Resolved <- "0 = NO"
dataa <- rbind(summary_source0, summary_source1)


# 3 Plot Source of Infection Data and outcomes 
SourceInfection_Outcomes <- ggplot(dataa, aes(fill=Resolved, y=count, x=`Source of Infection`)) +
  geom_bar(position="dodge", stat="identity")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  labs(x = "Source of Infection", 
       y = "Number of cases",
       title = "Recovery Outcomes by Source of Infection")
SourceInfection_Outcomes
ggsave("outputs/figures/SourceInfection_Outcomes.pdf")


# Summarize age groups
summary_age <- COVID19_cases_clean2 %>% 
  group_by(`Age Group`) %>% 
  summarise(count=n())

# 4 Plot Distribution for Infected Age Groups
Age <- ggplot(summary_age, aes(x =`Age Group`,y= count, fill=`Age Group`)) + 
  geom_bar(stat="identity") + 
  theme_minimal()+ theme(legend.position = "none")+ 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  labs(x = "Age Groups", 
       y = "Number of cases",
       title = "Distribution of Infected Age Groups")
Age
ggsave("outputs/figures/Age.pdf")


# Preparing Age Plot Data in frame  
summary_source1 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 1) %>%
  group_by(`Age Group`) %>% 
  summarise(count = n())

summary_source1$Resolved <- "1 = YES"

summary_source0 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 0) %>%
  group_by(`Age Group`) %>% 
  summarise(count = n())

summary_source0$Resolved <- "0 = NO"
dataa <- rbind(summary_source0, summary_source1)


# 5 Plot Age Data and outcomes 
AgeOutcomes <- ggplot(dataa, aes(fill=Resolved, y=count, x=`Age Group`)) +
  geom_bar(position="dodge", stat="identity")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  labs(x = "Age", 
       y = "Number of cases",
       title = "Recovery Outcomes by Age")
AgeOutcomes
ggsave("outputs/figures/AgeOutcomes.pdf")



# summarize gender
summary_gender <- COVID19_cases_clean2 %>% 
  group_by(`Client Gender`) %>% 
  summarise(count=n())

# 6 Plot Overall Gender Distribution
Gender <- ggplot(summary_gender, aes(x= `Client Gender`, y=count, fill= `Client Gender`)) + 
  geom_bar(stat="identity") +
  theme_minimal()+ theme(legend.position = "none")+ 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(x = "Genders",
       y = "Number of cases",
       title = "Distribution of Gender")
Gender
ggsave("outputs/figures/Gender.pdf")


# Preparing Gender Outcomes Plot Data in frame  
summary_source1 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 1) %>%
  group_by(`Client Gender`) %>% 
  summarise(count = n())

summary_source1$Resolved <- "1 = YES"

summary_source0 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 0) %>%
  group_by(`Client Gender`) %>% 
  summarise(count = n())

summary_source0$Resolved <- "0 = NO"
dataa <- rbind(summary_source0, summary_source1)

# 7 Plot Gender Outcomes Data and outcomes 
GenderOutcomes <- ggplot(dataa, aes(fill=Resolved, y=count, x=`Client Gender`)) +
  geom_bar(position="dodge", stat="identity")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  labs(x = "Gender", 
       y = "Number of cases",
       title = "Recovery Outcomes by Gender")
GenderOutcomes
ggsave("outputs/figures/GenderOutcomes.pdf")


# Preparing Ever Hospitalized Plot Data in frame  
summary_source1 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 1) %>%
  group_by(`Ever Hospitalized`) %>% 
  summarise(count = n())

summary_source1$Resolved <- "1 = YES"

summary_source0 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 0) %>%
  group_by(`Ever Hospitalized`) %>% 
  summarise(count = n())

summary_source0$Resolved <- "0 = NO"
dataa <- rbind(summary_source0, summary_source1)

dataa <- dataa %>%
  mutate(`Ever Hospitalized` = ifelse (`Ever Hospitalized` == 0, "NO", "YES"))

# 8 Plot Ever Hospitalized Data and outcomes 
Hospitalization <- ggplot(dataa, aes(fill=Resolved, y=count, x=`Ever Hospitalized`)) +
  geom_bar(position="dodge", stat="identity")+
  labs(x = "Hospitalization", 
       y = "Number of cases",
       title = "Recovery Outcomes based on Hospitalization")
Hospitalization
ggsave("outputs/figures/Hospitalization.pdf")

# Preparing Ever in ICU Plot Data in frame  
summary_source1 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 1) %>%
  group_by(`Ever in ICU`) %>% 
  summarise(count = n())

summary_source1$Resolved <- "1 = YES"

summary_source0 <- COVID19_cases_clean2 %>% 
  filter(Outcome == 0) %>%
  group_by(`Ever in ICU`) %>% 
  summarise(count = n())

summary_source0$Resolved <- "0 = NO"
dataa <- rbind(summary_source0, summary_source1)

dataa <- dataa %>%
  mutate(`Ever in ICU` = ifelse (`Ever in ICU` == 0, "NO", "YES"))

# 9 Plot Ever in ICU Data and outcomes 
ICU <- ggplot(dataa, aes(fill=Resolved, y=count, x=`Ever in ICU`)) +
  geom_bar(position="dodge", stat="identity")+
  labs(x = "ICU Admission", 
       y = "Number of cases",
       title = "Recovery Outcomes based on ICU Admission")
ICU
ggsave("outputs/figures/ICUadmission.pdf")



 
  
