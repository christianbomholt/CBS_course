setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readxl)
library(dplyr)
optioner <- read_excel("../data/xl/SPXoptions.xlsx")

liquid_options <- optioner %>% 
  mutate(bid_ask = bid-ask) %>% 
  filter(bid_ask<5) %>% 
  filter(bid!=0) %>% 
  filter(cp_flag!="C") %>% 
  mutate(moneyness = abs(strike/2080.15-1)) %>% 
  filter(moneyness<0.4) %>% 
  filter(strike<1800) %>% 
  select(bid,ask,exdate,cp_flag,mid)

save(liquid_options, file = "../data/")