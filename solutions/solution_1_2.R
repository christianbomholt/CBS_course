setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(readxl)
library(dplyr)

optioner <- read_excel("../data/xl/SPXoptions.xlsx")

S_init = 2080.15

optioner_filtered<-optioner %>% mutate(bid_ask = ask-bid) %>% 
  mutate(moneyness = abs(strike/S_init-1)) %>% 
  filter(bid_ask<5) %>%
  filter(moneyness<0.4) %>%
  filter(bid!=0) %>%
  filter(strike>1800) %>%
  filter(cp_flag=="C") %>% 
  select(mid,cp_flag,bid,ask,strike,exdate) %>% 
  mutate(exdate = as.factor(as.character(exdate)))

library(plotly)
library(tidyr)

plot_ly(optioner,
        x= ~strike,
        y= ~mid,
        type="scatter",
        mode = "markers",
        color = ~exdate)



S_init = 2080.15
df <- optioner %>%
  mutate(b_bool =if_else(bid!=0,"Bid>0","Bid=0") %>% as.factor()) %>% 
  mutate(moneyness = abs(strike/S_init-1)) %>% 
  mutate(bid_ask = ask-bid) 

plot_ly(df,
        x = ~moneyness,
        y= ~bid_ask,
        symbol = ~b_bool,
        type = "scatter",
        mode = "markers") %>% 
  layout(xaxis=list(title="|K/S-1|"), yaxis= list(title="Bid-ask spread"),
         shapes = list(
           list(type = "rect",
                fillcolor = 'rgb(0,128,128)', line = list(color = 'rgb(0,128,128)'), opacity = 0.3,
                x0 = 0.4, x1 = 1, xref = "x",
                y0 = 0, y1 = 20, yref = "y"),
           list(type = "rect",
                fillcolor = 'rgb(255,165,0)', line = list(color = 'rgb(255,165,0)'), opacity = 0.3,
                x0 = 0, x1 = 1, xref = "x",
                y0 = 5, y1 = 20, yref = "y")))
