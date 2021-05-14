## CREATED BY: CLAUDIA REA
## CREATED ON: 20210514
#load libraries
library(tidyr)
library(dplyr)
library(tidyverse)
library(here)
library(ggplot2)



## LOAD DATA
bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')
view(bechdel)

## GROUP BY YEARS AND CAL MEAN RATINGS
mean_rating <- bechdel %>%
  group_by(year) %>% # group by year since there's a lot 
  summarize(mean = mean(rating, na.rm=TRUE))



## PLOTTING
ggplot(data = mean_rating, aes(x = year, y = mean, fill = year))+
  theme_light() + 
  geom_point(show.legend = FALSE)+
  geom_smooth(method = "lm", show.legend = FALSE)+
  labs(x = "",  y = "Score Ratings (Mean)", face ="bold", color="black", size=12)+
  scale_y_continuous(limits = c(0,3))+
  scale_x_continuous(breaks = c(1900, 1930, 1950, 1970, 1990, 2000, 2020))
  ggsave(here("Tidy2","Output","bechdel_scatterplot.png"))

