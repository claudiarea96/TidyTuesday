## Created by: Claudia Rea
## Created on: 20210420

### Load Libraries 
library(tidyverse)
library(ghibli)
library(lubridate)
library(here)
library(tidytuesdayR)
library(patchwork)


### Load Data 
employed <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-23/employed.csv')

employedClean <- employed %>% 
  filter(complete.cases(.)) #filters out incomplete rows


glimpse(employedClean)
view(employedClean)

#Employement Plot
EmployedGender<- employedClean %>% 
  filter(race_gender %in% c("Women", "Men")) %>% #filtered out gender
  select(race_gender,employ_n,year) %>% #selected columns for race/gender, employment number, and year
  ggplot(aes(x=employ_n, #created ggplot
             y=race_gender,
             fill=race_gender))+
  geom_bar(stat = "identity")+ #created bar plot
  theme_classic()+ 
  labs(x= "Number of Persons Employed", #labeled axis titles and figure
       title="Disparity in Employment by Gender")+
  theme(axis.title.y=element_blank(), #removed y-axis title
        axis.title.x = element_text(vjust = -0.5), #adjusted lower title 
        plot.title=element_text(hjust=0.5, #centered? bold title 
                                face="bold"),
        legend.title = element_blank())+ #removed legend title
  scale_fill_manual(values=ghibli_palette("MarnieLight1")[c(2,4)])+ #color scale 
  scale_x_continuous(labels=scales::unit_format(unit="M", 
                                                scale = 1e-6)) #changed x-axis title to millions
EmployedGender
