setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(readxl)
library(glmnet)

df <- read_excel('../data/xl/R.xlsx',col_names = T)
df$Date <- as.Date(df$Date,origin = '1970-01-01')

train <- df %>% filter(Date<'2013-01-01')
test <- df %>% filter(Date>='2013-01-01')

X <- train %>% select(-c(Date,Yield)) %>% 
  as.matrix()
y <- train$Yield

fit <- glmnet(X,y)
fit.values <- predict(fit,X)


fit <- cv.glmnet(X,y)
fit.values_1 <- predict(fit,X)


train %>% select(Date,Yield) %>%
  mutate(estimates = fit.values[,11]) %>% 
  mutate(estimates_new = fit.values_1) %>% 
plot_ly(x= ~Date, y = ~Yield, mode="markers") %>%
  add_trace(y = ~estimates, mode = 'lines', name = "Estimate") %>% 
  add_trace(y = ~Yield, mode = 'markers', name = "Actual") %>% 
  add_trace(y=~estimates_new, mode = 'makers', name="optimal")



X <- test %>% select(-c(Date,Yield)) %>% 
  as.matrix()

test_estimates<-predict(fit,X)

# Evaluer

mae <- function(fx,y){
  sum(abs(fx-y))
}

mae(test$Yield,test_estimates)
