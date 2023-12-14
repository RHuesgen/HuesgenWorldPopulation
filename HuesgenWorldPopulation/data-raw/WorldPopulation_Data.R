WorldPopulation <- World_Population %>%
  select(3|8:78) %>%
  rename(Country_Name= 'Region, subregion, country or area *')

WorldPopulation <- WorldPopulation[27:306, ]

WorldPopulation <- WorldPopulation %>%
  pivot_longer('1950':'2020',
               names_to = 'Year',
               values_to = 'Population')

head(WorldPopulation)
