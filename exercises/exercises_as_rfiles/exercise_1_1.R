setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readr)
library(dplyr)
wines <- read_csv("../data/winemag-data-130k-v2.csv")[,-1]
