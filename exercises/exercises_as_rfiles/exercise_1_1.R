setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(plotly)
wines <- read_csv("../../data/winemag-data-130k-v2.csv")

df <- wines %>% group_by(country) %>%  summarise(meanscore = mean(points)) %>% arrange(meanscore)

plot_ly(df, x= df$country, y= df$meanscore)

