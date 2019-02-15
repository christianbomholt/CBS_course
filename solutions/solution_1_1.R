setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# The data was scraped from WineEnthusiast during the week of June 15th, 2017. The code for the scraper can be found here if you have any more specific questions about data collection that I didn't address.

library(readr)
library(dplyr)
wines <- read_csv("../data/winemag-data-130k-v2.csv")[,-1]

# En masse tie-breakers
topwines <- wines %>%
  group_by(title) %>%
  mutate(avg_price = mean(price,na.rm = T)) %>%
  mutate(avg_score = mean(points,na.rm = T)) %>%
  arrange(desc(points))

topwines %>% filter(points >= 98) %>% nrow()

# Give me the best and cheapest
topwines %>% arrange(desc(points),price) %>% head

# Value for money 
topwines %>% 
  mutate(value_for_money = avg_score/avg_price ) %>% 
  arrange(desc(value_for_money)) %>%
  select(value_for_money,country,title,province,price,points) %>%
  head()

# Yields discount store wine..

# Add a filter
topwines %>% 
  mutate(value_for_money = avg_score/avg_price ) %>% 
  filter(points>95) %>% 
  arrange(desc(value_for_money)) %>%
  select(value_for_money,country,title,province,price,points) %>%
  head()





