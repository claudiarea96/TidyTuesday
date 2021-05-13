### Tidy Tuesday Week 12
### Created by: Claudia Rea
### Created on 20210512

### Load Libraries
library(tidyverse)
library(here)
library(lubridate)

### Load Data
netflix_titles <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-04-20/netflix_titles.csv')
view(netflix_titles)
### Clean data
netflix_us <- netflix_titles %>% 
  select(title,country,date_added,listed_in) %>% 
  separate_rows(country, sep = ", ") %>% 
  filter(country == "United States", listed_in == "Horror Movies") %>% # filter out horror movies produced in US
  mutate(date_added = mdy(date_added)) %>%
  mutate(year = year(date_added)) %>% 
  mutate(year = factor(year,levels = c("2016","2017","2018","2019","2020","2021"))) %>% # filter out only last 6 years
  group_by(year) %>% 
  na.omit() %>% # ommit all NA values 
  count(year)

### List the data
nf_us_plot <- netflix_us %>% 
  ggplot(aes(x = year, y = n))+
  geom_bar(stat = "identity")+
  labs(title = "Horror Movies Produced by Year",
       captions = "Source: Tidytuesday")

nf_us_plot
