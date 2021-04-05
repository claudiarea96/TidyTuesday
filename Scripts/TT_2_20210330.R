### Load Libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(magick)
library(tvthemes)
library(ggplot2)

### Get Data
Shades2 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allShades.csv')
## Mutate and ilter 
shades3 <- Shades2 %>% 
  select(brand, name, lightness) %>% #select only columns of interest, separate by shade
  mutate(shade = case_when( 
    lightness >= .75 ~ "Light", 
    lightness > 0.45 & lightness < 0.75 ~ "Medium",
    lightness <= 0.45 ~ "Deep"
  )) %>%
  group_by(brand) %>% #grouped by brand
  count(shade) %>% #counted the number of shades per brand
  filter(brand %in% c("Maybelline","CoverGirl","e.l.f. Cosmetics","L'Oréal","ULTA","Wet n Wild"))

## view new dataset  
glimpse(shades3)
view(shades3)

## Plot
ShadesPlot <- shades3 %>% 
  ggplot(aes(x = shade,
             y = n,
             fill = shade))+
  geom_col()+
  scale_x_discrete(limits = c("Light", "Medium","Deep"))+ #organize by shades (L,M,D)
  guides(fill=FALSE)+
  facet_wrap(~brand, #facet wrap individual brand
             scales = "free", #free sclae Y axis
             ncol = 3)+ #3 columns per grid
  theme_bw()+ #theme
  labs(title = "Deep Shades Per Low-Cost Brand", # title, subtitle, caption
       subtitle = "Number of deep fundation shades carried by low-cost brands",
       caption = "Source: ThePudding, TidyTuesday",
       x = " ", y = " ")+ #rno axis labels
  theme_replace()
ShadesPlot

