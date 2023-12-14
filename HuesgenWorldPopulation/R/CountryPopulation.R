#' Country Population function!
#'
#' This is a function that takes a country name from the dataset
#' CountryPopulation and returns a plot of that country's
#' population between 1950 and 2020.
#'
#' @param country.name A country name as a string.
#' @export

library(tidyverse)
library(rvest)
library(dplyr)
library(stringr)
library(readxl)
library(cowplot)

World_Population <- read_excel('data-raw/World_Population.xlsx', sheet = 1, range="A17:BZ306")

WorldPopulation <- World_Population %>%
  select(3|8:78) %>%
  rename(Country_Name= 'Region, subregion, country or area *')

WorldPopulation <- WorldPopulation[27:306, ]

WorldPopulation <- World_Population %>%
  select(3|8:78) %>%
  rename(Country_Name= 'Region, subregion, country or area *')

WorldPopulation <- WorldPopulation[27:306, ]

WorldPopulation <- WorldPopulation %>%
  pivot_longer('1950':'2020',
               names_to = 'Year',
               values_to = 'Population')

CountryPopulation <- function(country.name) {
  country.data <- WorldPopulation %>%
    filter(WorldPopulation$Country_Name  == country.name)
  if(!(country.name %in% WorldPopulation$Country_Name)) {
    stop("Country is not in the dataset.")
  }

  ggplot(country.data, aes(x=Year, y=Population, group=Country_Name)) +
    geom_line() +
    scale_y_discrete(labels= scales::comma, breaks=seq(0,100000, by=20000)) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_x_discrete(breaks= seq(1950,2020,by=3)) +
    labs(x='Year', y='Population', title=paste("Population from 1950-2020:", country.name))
}

usethis::use_testthat()
