# Created by: Claudia Rea
# Created on: 20210512

### LoaD LIBRARIES

library(here)
library(tidyverse)
library(tidytext)
library(scales)
### LOAD DATA
SB_brands <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-02/youtube.csv') %>% 
  select(-favorite_count) 

View(SB_brands)
### MUTATE DATA
brands <- SB_brands %>% 
  count(brand, sort = TRUE) %>% 
  head(20) %>% 
  mutate(brand = fct_reorder(brand, n)) %>% 
  ggplot(aes(n, brand))+
  geom_col()

unique(SB_brands$brand)


categories<- SB_brands %>%
  gather(category, value, funny:use_sex) %>%  # created vector 
  mutate(category = str_to_title(str_replace_all(category, "_"," "))) 
# gather by columns 


### PLOTTING 
categories %>% 
  group_by(year, brand) %>% # group by brand and category 
 
  ggplot(aes(year, brand))+ # plot x and y 
  geom_col(fill = "#DA3F3F", # plotted columns  
           color = "#BBD7C0")+
  scale_x_continuous()+ 
  scale_y_reordered()+ 
  theme_bw()+ 
  labs(x = "Ads Per Brand Shown During the SuperBowl", # labels
       y = "Brand", 
       title = "Superbowl Commercials Per Brand",
       caption = "Source: TidyTuesday")
  ggsave(here("Tidy3","output","supercat.png"), # save
         width = 9, height = 9)
