library(ggplot2)
library(rstan)
rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

d <- read.csv('data-salary-2.txt')

data <- list(
  N=nrow(d),
  K=4,
  X=d$X, 
  Y=d$Y,
  KID=d$KID
)

fit <- stan(
  file='model8-2.stan', 
  data=data, 
  seed=1234
)

fit

#save.image('result-model8-1.RData')
