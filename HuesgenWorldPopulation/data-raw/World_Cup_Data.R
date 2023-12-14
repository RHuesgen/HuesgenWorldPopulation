library(tidyverse)
library(rvest)
library(dplyr)
library(stringr)
library(readxl)
library(cowplot)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
page <- read_html(url)

Table <- page %>%
  html_nodes('table.wikitable') %>%
  .[[2]] %>%
  html_table(header=FALSE, fill = TRUE) %>%
  magrittr::set_colnames(c('Year','Hosts','Venues/Cities','Totalattendance', 'Matches','Averageattendance','Number','Venue','Game(s)')) %>%
  slice(-2, )

Table <- Table[-1, ]

World_Cup <- Table %>%
  mutate(
    Year = as.character(Year),
    Totalattendance=as.numeric(str_replace_all(Totalattendance, pattern='\\,', replace="")),
    Averageattendance = as.numeric(str_replace_all(Averageattendance, pattern="\\,", replace=""))
  ) %>%
  select(1:2|4:6)

World_Cup <- World_Cup[1:22, ]

usethis::use_data(World_Cup)
