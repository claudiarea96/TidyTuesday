### Load Libraries
library(tidyverse)
library(here)
library(tidytuesdayR)
library(magick)
library(tvthemes)
library(ggplot2)

### Get Data
Shades <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-30/allShades.csv')
## Mutate and ilter 
shades <- Shades %>% 
  select(brand, name, lightness) %>% #select only columns of interest, separate by shade
  mutate(shade = case_when( 
    lightness >= .75 ~ "Light", 
    lightness > 0.45 & lightness < 0.75 ~ "Medium",
    lightness <= 0.45 ~ "Deep"
  )) %>%
  group_by(brand) %>% #grouped by brand
  count(shade) %>% #counted the number of shades per brand
  filter(brand %in% c("Clinique","Dior","Lancôme","MAC","NARS","Yves Saint Laurent"))
                    
## view new dataset  
glimpse(shades)
view(shades)

## Plot
ShadesPlot <- shades %>% 
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
  labs(title = "Deep Shades Per High-End Brand", # title, subtitle, caption
       subtitle = "Number of deep fundation shades carried by high-end brands",
       caption = "Source: ThePudding, TidyTuesday",
       x = " ", y = " ")+ #rno axis labels
  theme_parksAndRecLight()
ShadesPlot
