## Created by: Claudia Rea
## Created on: 20210513

## LOAD LIBRARIES
library(PNWColors)
library(lubridate)
library(tidytuesdayR)
library(tidyverse)
library(here)
library(dplyr)


## LOAD DATA
wawa <- tidytuesdayR::tt_load('2021-05-04')
water <- wawa$water 
view(tuesdata)
view(water)

water_clean <- water[complete.cases(water),] # remove any NAs 

water_plot <- water_clean%>%
  select(country_name, water_source)%>% # select by source type
  group_by(country_name)%>% # group by country, did not use in the end 
  summarise(water_source)

view(water_plot)

## PLOT 
water_plot%>%
  ggplot(aes( y = water_source))+ # only want y axis 
  geom_bar()+ # plotted bar graph
  labs(title = "Types of Water Sources Across Africa", # Label the title
       y = "Type of Water Source", # lonly laveled y axis
       caption = "data from tidytuesday")+ # add a caption 
  theme_hildaDusk()+ 
  theme(axis.title.x=element_blank(),
              axis.text.x=element_blank(),
              axis.ticks.x=element_blank()) # took off all x labels 
  ggsave(here("05_04_21", "Output", "Water_source.png"), width = 7 , height = 5) # save the plot