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

# total number of schools by school type
schools %>% 
  group_by(TypeOfEstablishment, Open) %>%
  summarise(total = n())

# 4.2 Piping - filter and select
# filter results to find schools teaching Chinese

results %>% 
  filter(Description == "Chinese") %>%
  filter(Grade == "Total number entered") %>%
  select(ID, School, Total_students, Description, Entries)

# mutate to add % of school taking subject
# filter on this

results %>% filter(Description == "Chinese") %>%
  filter(Grade == "Total number entered") %>%
  select(ID, School, Total_students,Description, Entries) %>%
  mutate(per = Entries/Total_students) %>%
  filter(per > 0.5)


## arrange




































