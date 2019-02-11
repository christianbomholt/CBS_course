setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
library(plotly)
library(broom)


avocados <- read_csv("../data/avocado.csv") %>%
  filter(region=="Albany") %>% 
  filter(type=="conventional")

fit <- lm(AveragePrice~total_volume+year, data = avocados)

broom::tidy(fit)




###### PLOT #######

avocados %>% mutate(estimates = predict(fit,data = .)) %>% 
  select(AveragePrice,total_volume,estimates) %>% 
  plot_ly(x= ~total_volume, y = ~AveragePrice, mode="markers") %>%
  add_trace(y = ~estimates, mode = 'lines', name = "Estimate") %>% 
  add_trace(y = ~AveragePrice, mode = 'markers', name = "Actual")
