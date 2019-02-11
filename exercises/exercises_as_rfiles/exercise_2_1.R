setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(plotly)
library(dplyr)
data <- read_csv("../data/avocado.csv") %>%
  filter(region == "Boston" | region == "Albany")
