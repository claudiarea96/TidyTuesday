## Load libraries 
library(tidyverse)
library(tidytuesdayR)
library(here)
library(tvthemes)
library(PNWColors)

## Read data set in 
brazil_loss <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-06/brazil_loss.csv')
glimpse(brazil_loss)

# Mutate data 
brazil <- brazil_loss %>% 
  pivot_longer(cols = 4:14, #pivot data to show individual cause per loss
               names_to = "cause",
               values_to = "loss") %>% 
  select(year,cause,loss) %>% #sselect only Year, Cause, Loss
  group_by(year) %>%    #group by year 
  mutate(loss_perc = (loss/sum(loss))) %>% # ratio of loss per year
  mutate(cause = recode(cause, #Fix labs 
                        'commercial_crops' = "Commericial Crops",'mining' = "Mining",'pasture' = "Pasture",
                        'small_scale_clearing' = "Small Scale Clearing", 'fire' = "Fire",
                        'natural_disturbances' = "Natural Disturbances",
                        'roads' = "Roads",'tree_plantations_including_palm' = "Tree Plantations",
                        'flooding_due_to_dams' = "Flooding by dams",'other_infrastructure' = "Other Infrastructure",
                        'selective_logging' = "Selective Logging")) 
view(brazil) #view new dataset 

## Plotting 
brazilBox <- brazil %>% 
  ggplot(aes(x=year, y=loss_perc,fill=cause))+ #create boxplot
  geom_boxplot()+
  scale_x_continuous(labels=c(2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013), #x axis years only
                     breaks=c(2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013))+ 
  labs(title = "Brazil Deforestation Causes", #titles
       caption = "Source: Our World in Data, Tidytuesday",
       x = " ", y = "Total Loss")+
  guides(fill = guide_legend(title="Cause"))+
  theme_classic()+ 
  scale_y_continuous(labels = scales::percent) #change y axis to percents


brazilBox 
