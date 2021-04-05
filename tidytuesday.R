library(tidytuesdayR)
library(tidyverse)
library(here)
library(RgoogleMaps)

# Get the Data

# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest

# Either ISO-8601 date or year/week works!

tuesdata <- tidytuesdayR::tt_load('2021-03-09')
tuesdata <- tidytuesdayR::tt_load(2021, week = 11)

bechdel <- tuesdata$bechdel
view(bechdel)
# Or read in the data manually

raw_bechdel <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/raw_bechdel.csv')
movies <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-09/movies.csv')
view(raw_bechdel)
glimpse(movies)

CP_Movie <- movies %>%
  select(year,clean_test,binary,genre)
  group_by(genre,binary) %>%
  ggplot(data = CP_Movie, 
         mapping = aes(x = binary, 
                       y = genre)) +
  geom_bar(stat='identity')

CP_Movie
rlang::last_error()
view(CP_Movie)
