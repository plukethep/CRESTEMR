install.packages("openxlsx")
library(openxlsx)
library(tidyverse)

results <- read.xlsx("https://drive.google.com/uc?export=download&id=1tp9xe3dS__eg7RrXf0T_oMxcrz_TbMdM",
                     sheet="Results")
results %>%
  group_by(Grade) %>%
  summarise(Grade_total = sum(Entries, na.rm = TRUE)) %>%
  head(6) 

str(results)

 # %>% mutate()

grepl("SUPP", unique(results$Entries))

################################################################
#### Intro:

# This example shows how R can pull data directly from the internet
# tidy it and start making graphs. All within 9 lines of code
library(tidyverse)

education <- read_csv(
  "https://barrolee.github.io/BarroLeeDataSet/BLData/BL_v3_MF.csv")

education %>%
  filter(agefrom == 15, ageto == 24,
         country %in% c("Germany","France","Italy","United Kingdom")) %>%
  ggplot(aes(x=year, y=yr_sch, colour=country)) +
  geom_point() +
  geom_line()

################################################################
# 3.1  Objects and instructions
## outputting name and hours in year, note datatypes

# show how to create a new script
# show how to run code

myname <- "Pete"
print(myname)


HoursInYear <- 365 * 24
print(HoursInYear) 




# DO: Type the two examples above into your RStudio script file and 
# check that they work. Adapt them to say your full name and give 
# the number of MinutesInADay



################################################################
# 3.2 naming objects and comments, average sales example


income1 <- 132   # difference between number and text
income2 <- "665"   # demonstrate comments
income3 <- 233
income4 <- 1200


shops <- 4
avgSales <- (income1 + income2 + income3 + income4) / shops
print(avgSales)


################################################################
# 4.1 loading example

# highlight slashes
# use full address
library(tidyverse)
library(readxl)

results <- read_excel("C:/Users/Peter/Google Drive/Kings/R intro/code/dfe_data.xlsx", "Results")
schools <- read_excel("C:/Users/Peter/Google Drive/Kings/R intro/code/dfe_data.xlsx", "Schools")

# explore the dataset


# 4.1 exploring the dataset, sum, nrow, max, min, $, unique, schools$NumberOfBoys NA
nrow(results)
ncol(results)
names(schools)
schools$
  
unique()
# remove NA
mean(schools$NumberOfBoys)


mean height of characters by sex
max mass per homeworld

################################################################
# 4.2 group_by summarise
# find the max number of boys in a given primary or secondary grouping

results %>% 
  group_by(ID) %>%
  summarise(Total = unique(Total_students)) %>%  # do up to here first
  ungroup() %>%
  summarise(Grand_Total = sum(Total))

# find number of entries by subject
sub_entries <- results %>%
  group_by(ID, Description) %>%
  summarise(Total = max(Entries)) %>%
  group_by(Description) %>%
  summarise(Subject_Total = sum(Total, na.rm=TRUE))

results %>% select(ID, Description, Grade, Entries)

# total number of schools by school type
schools %>% 
  group_by(TypeOfEstablishment, Open) %>%
  summarise(total = n())


########################
# 4.2 Piping - filter and select

# add simple example
# want to find where the most impoverished areas of England are for secondary children

schools %>%
  filter(Open == "Open", ## NOTE: ==
         Phase == "Secondary", 
         FSM > 0.5) %>%
  select(ID, LA, Name, FSM) %>%
  mutate(FSM = 100 * FSM)


# filter results to find schools teaching Chinese
results %>% 
  filter(Description == "Chinese") %>%
  filter(Grade == "Total number entered") %>% 
  filter(Qualification == "GCSE (9-1) Full Course") %>% 
  select(ID, School, Total_students, Description, Entries)

# mutate to add % of school taking subject
# filter on this

results %>% 
  filter(Description == "Chinese") %>%
  filter(Grade == "Total number entered") %>%
  filter(Qualification == "GCSE (9-1) Full Course") %>% 
  select(ID, School, Total_students,Description, Entries) %>%
  mutate(per = Entries/Total_students) %>%
  filter(per > 0.5)


# 4.4 save
# talk about working directories
getwd()
setwd("C:/Users/Peter/Google Drive/Kings")

chinese_uptake <- data_joined %>% 
  filter(Description == "Chinese", 
         Grade == "Total number entered",
         Qualification == "GCSE (9-1) Full Course") %>% 
  select(ID, Total_students, Description, 
         Entries, FSM, NumberOfBoys, NumberOfGirls)

# This will save to your "working directory", where you have saved 
write.csv(chinese_uptake, "chinese_entries.csv", row.names = FALSE)

#### TIMSS dataset
library(openxlsx)
TIMSS <- read.xlsx("https://drive.google.com/uc?export=download&id=1Sgyw1tLbPGsl4HeyhpNGLhJwTNIriE-B", "school_data")

#############################
######## GGPLOT
school_plot_data <- schools %>% 
  filter(Open == "Open", 
         Phase=="Secondary")


ggplot(data=school_plot_data, 
       aes(x=NumberOfBoys, y=NumberOfGirls)) +
  geom_point() +
  geom_smooth(method='lm') +
  ggtitle("What is the gender split of schools") +
  xlab("Boys in school") +
  ylab("Girls in school")

###### plot computing 
data_joined <- left_join(results, schools, by="ID")

# wrangle our data
# grepl looks for the word “Comput” in the string Description
computing_test <- data_joined %>%
  filter(grepl("Comput", Description),
         Qualification == "GCSE (9-1) Full Course",
         Grade == "Total number entered" ) %>%
  select(ID, Total_students, Entries, Gender, 
         FSM, NumberOfBoys, NumberOfGirls) %>%
  mutate(per_male =
           NumberOfBoys / (NumberOfBoys + NumberOfGirls),
         per_taking_cs = Entries/Total_students) %>%
  arrange(desc(per_taking_cs))


ggplot(data=computing_test, 
       aes(x=per_male, y=per_taking_cs)) +
  # geom_point(aes(size = FSM, colour=Gender)) +
  geom_point() +
  geom_smooth(method='lm') +
  ggtitle("The more boys, the more CS")

#### Questions


## ifelse for Grammar schools


## Questions



BCBGEAS - School Emph on Acad Success
BCBGDAS

































